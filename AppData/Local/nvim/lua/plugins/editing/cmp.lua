return {
	"saghen/blink.cmp",
	version = "1.*",
	event = "InsertEnter",
	dependencies = { "rafamadriz/friendly-snippets" },
	opts = {
		keymap = {
			preset = "default",
			["<Tab>"] = false,
			["<S-Tab>"] = false,
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		cmdline = {
			enabled = false,
		},
		completion = { documentation = { auto_show = false } },
		sources = {
			default = { "lsp", "path", "snippets" },
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
