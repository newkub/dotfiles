return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"cssls",
					"html",
					"html",
					"ts_ls",
					"pyright",
					"bashls",
				},
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettier",
					"stylua",
					"eslint_d",
					"shellcheck",
					"stylua",
					"oxlint",
				},
			})
		end,
	},
}
