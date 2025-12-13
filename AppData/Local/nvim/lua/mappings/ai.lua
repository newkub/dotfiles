-- AI assistance key mappings for Neovim

return {
  i = {
    -- GitHub Copilot
    ["<M-l>"] = { "copilot#Accept('')", "Accept Copilot Suggestion", { expr = true, silent = true } },
    ["<M-[>"] = { "copilot#Previous()", "Previous Copilot Suggestion", { expr = true } },
    ["<M-]>"] = { "copilot#Next()", "Next Copilot Suggestion", { expr = true } },
    ["<C-]>"] = { "copilot#Dismiss()", "Dismiss Copilot Suggestion", { expr = true } },

    -- Codeium (Windsurf)
    ["<M-=>"] = { "codeium#Accept()", "Accept Codeium Suggestion", { expr = true } },
    ["<M->>"] = { "codeium#CycleCompletions(1)", "Next Codeium Completion", { expr = true } },
    ["<M-<>"] = { "codeium#CycleCompletions(-1)", "Previous Codeium Completion", { expr = true } },
  },
}