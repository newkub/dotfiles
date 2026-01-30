import { defineConfig } from "@agent-tars/interface";

export default defineConfig({
  model: {
    provider: "openai",
    baseURL: "https://api.deepseek.com",
    apiKey: process.env.DEEPSEEK_API_KEY,
    id: "deepseek-chat",
  },
  browser: {
    control: "hybrid",
  },
  mcpServers: {
    "mcp-server-chart": {
      command: "bunx",
      args: ["-y", "@antv/mcp-server-chart"],
    },
  },
});
