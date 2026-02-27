-- AI assistance key mappings for Neovim

return {
	i = {
		-- Codeium (Windsurf)
		["<M-=>"] = { "codeium#Accept()", "Accept Codeium Suggestion", { expr = true } },
		["<M->>"] = { "codeium#CycleCompletions(1)", "Next Codeium Completion", { expr = true } },
		["<M-<>"] = { "codeium#CycleCompletions(-1)", "Previous Codeium Completion", { expr = true } },
	},
}
