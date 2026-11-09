// ghostex-amp-session-extension-marker v5
import { spawn } from "node:child_process";
import * as fs from "node:fs";
import * as path from "node:path";
import type {
  PluginAPI,
  AgentEndEvent,
  AgentStartEvent,
  SessionStartEvent,
  ToolCallEvent,
  ToolResultEvent,
} from "@ampcode/plugin";

function firstString(...values: unknown[]): string | null {
  for (const value of values) {
    if (typeof value === "string" && value.trim().length > 0) return value.trim();
  }
  return null;
}

function resolveExecutable(name: string): string {
  const pathEnv = process.env.PATH || "";
  for (const dir of pathEnv.split(path.delimiter)) {
    if (!dir) continue;
    const candidate = path.join(dir, name);
    try {
      fs.accessSync(candidate, fs.constants.X_OK);
      return candidate;
    } catch (_) {}
  }
  return name;
}

function looksLikeAmpExecutable(value: string): boolean {
  return path.basename(value).toLowerCase() === "amp";
}

function looksLikeAmpScript(value: string): boolean {
  const normalized = value.replaceAll("\\", "/");
  const base = path.basename(normalized).toLowerCase();
  return normalized.includes("/@ampcode/") || (base === "cli.js" && normalized.includes("amp"));
}

function looksLikeJavaScriptRuntime(value: string): boolean {
  const base = path.basename(value).toLowerCase();
  return base === "node" || base === "bun" || base === "deno" || base === "tsx" || base === "ts-node";
}

function normalizedLaunchArgv(): string[] {
  const raw = Array.isArray(process.argv) ? process.argv.map((value) => String(value)) : [];
  if (raw.length === 0) return [resolveExecutable("amp")];
  if (looksLikeAmpExecutable(raw[0])) return raw;
  if (raw.length > 1 && (looksLikeAmpScript(raw[1]) || looksLikeJavaScriptRuntime(raw[0]))) {
    return [resolveExecutable("amp"), ...raw.slice(2)];
  }
  return [resolveExecutable("amp")];
}

function base64NulSeparated(values: string[]): string {
  const bytes: Buffer[] = [];
  for (const value of values) {
    bytes.push(Buffer.from(String(value), "utf8"));
    bytes.push(Buffer.from([0]));
  }
  return Buffer.concat(bytes).toString("base64");
}

function hookEnvironment(cwd: string): NodeJS.ProcessEnv {
  const env: NodeJS.ProcessEnv = { ...process.env, GHOSTEX_AGENT: "amp" };
  delete env.AMP_API_KEY;
  for (const key of ["ANSI_COLORS_DISABLED", "NO_COLOR", "NODE_DISABLE_COLORS"]) delete env[key];
  if (!env.GHOSTEX_AGENT_LAUNCH_ARGV_B64) {
    const argv = normalizedLaunchArgv();
    env.GHOSTEX_AGENT_LAUNCH_KIND = "amp";
    env.GHOSTEX_AGENT_LAUNCH_EXECUTABLE = argv[0] || resolveExecutable("amp");
    env.GHOSTEX_AGENT_LAUNCH_ARGV_B64 = base64NulSeparated(argv);
    env.GHOSTEX_AGENT_LAUNCH_CWD = cwd || process.cwd();
  }
  return env;
}

function threadIdFrom(event: { thread?: { id?: string } } | undefined, ctx?: { thread?: { id?: string } }): string | null {
  return firstString(event?.thread?.id, ctx?.thread?.id);
}

function sendHook(
  eventName: string,
  sessionId: string | null,
  cwd: string,
  extra: Record<string, unknown> = {},
): void {
  if (process.env.GHOSTEX_AMP_HOOKS_DISABLED === "1") return;
  if (!sessionId) return;
  const payload: Record<string, unknown> = {
    agent: "amp",
    cwd,
    event: eventName,
    hook_event_name: eventName,
    session_id: sessionId,
    ...extra,
  };
  // Windows cannot run the notify hook script itself; gxserver runs it for the agent there.
  const [command, args] =
    process.platform === "win32"
      ? ["C:\\Users\\Veerapong\\AppData\\Local\\Ghostex\\current\\resources\\native\\gxserver.exe", ["agent-hook-notify-native", "C:\\Users\\Veerapong\\AppData\\Local\\Ghostex\\Data\\hooks/agent-shell-notify.sh", "amp"]]
      : ["C:\\Users\\Veerapong\\AppData\\Local\\Ghostex\\Data\\hooks/agent-shell-notify.sh", []];
  try {
    const child = spawn(command, args, {
      stdio: ["pipe", "ignore", "ignore"],
      env: hookEnvironment(cwd),
      detached: true,
      windowsHide: true,
    });
    child.on("error", () => {});
    child.stdin.on("error", () => {});
    child.stdin.end(JSON.stringify(payload));
    child.unref();
  } catch (_) {}
}

export default function ghostexAmpSessionPlugin(amp: PluginAPI) {
  const cwdFromEnv = (): string => firstString(process.env.PWD, process.cwd()) || process.cwd();

  amp.on("session.start", async (event: SessionStartEvent, ctx) => {
    sendHook("SessionStart", threadIdFrom(event, ctx), cwdFromEnv());
  });

  amp.on("agent.start", async (event: AgentStartEvent, ctx) => {
    sendHook("UserPromptSubmit", threadIdFrom(event, ctx), cwdFromEnv());
  });

  amp.on("tool.call", async (event: ToolCallEvent, ctx) => {
    sendHook("PreToolUse", threadIdFrom(undefined, ctx), cwdFromEnv(), { tool: event.tool });
    return { action: "allow" as const };
  });

  amp.on("tool.result", async (event: ToolResultEvent, ctx) => {
    sendHook("PostToolUse", threadIdFrom(undefined, ctx), cwdFromEnv(), {
      tool: event.tool,
      is_error: event.status === "error",
    });
  });

  // Only a `done` turn finished; a cancel (Esc) or an error ends it without finishing it.
  amp.on("agent.end", async (event: AgentEndEvent, ctx) => {
    const name = event.status === "cancelled" ? "Interrupt" : event.status === "error" ? "StopFailure" : "Stop";
    sendHook(name, threadIdFrom(event, ctx), cwdFromEnv(), { status: event.status });
  });
}
