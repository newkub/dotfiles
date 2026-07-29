return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local parsers = {
			"lua",
			"vim",
			"vimdoc",
			"query",
			"javascript",
			"typescript",
			"tsx",
			"html",
			"css",
			"json",
			"yaml",
			"markdown",
			"markdown_inline",
			"bash",
			"gitignore",
			"regex",
			"vue",
			"python",
		}

		require("nvim-treesitter").setup()

		-- Install parsers in the background after startup
		vim.defer_fn(function()
			pcall(require("nvim-treesitter").install, parsers)
		end, 0)

		-- Enable treesitter highlight and indent per buffer
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local ok = pcall(vim.treesitter.start, args.buf)
				if ok then
					pcall(function()
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end)
				end
			end,
		})

		-- Treesitter-based folding
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt.foldenable = false
	end,

	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
			init = function()
				vim.g.no_plugin_maps = true
			end,
			config = function()
				require("nvim-treesitter-textobjects").setup({
					select = {
						lookahead = true,
						selection_modes = {
							["@parameter.outer"] = "v",
							["@function.outer"] = "V",
							["@class.outer"] = "V",
						},
					},
					move = {
						set_jumps = true,
					},
				})

				local select = require("nvim-treesitter-textobjects.select")
				for _, mode in ipairs({ "x", "o" }) do
					vim.keymap.set(mode, "aa", function()
						select.select_textobject("@parameter.outer", "textobjects")
					end)
					vim.keymap.set(mode, "ia", function()
						select.select_textobject("@parameter.inner", "textobjects")
					end)
					vim.keymap.set(mode, "af", function()
						select.select_textobject("@function.outer", "textobjects")
					end)
					vim.keymap.set(mode, "if", function()
						select.select_textobject("@function.inner", "textobjects")
					end)
					vim.keymap.set(mode, "ac", function()
						select.select_textobject("@class.outer", "textobjects")
					end)
					vim.keymap.set(mode, "ic", function()
						select.select_textobject("@class.inner", "textobjects")
					end)
				end

				local move = require("nvim-treesitter-textobjects.move")
				for _, mode in ipairs({ "n", "x", "o" }) do
					vim.keymap.set(mode, "]m", function()
						move.goto_next_start("@function.outer", "textobjects")
					end)
					vim.keymap.set(mode, "]M", function()
						move.goto_next_end("@function.outer", "textobjects")
					end)
					vim.keymap.set(mode, "[m", function()
						move.goto_previous_start("@function.outer", "textobjects")
					end)
					vim.keymap.set(mode, "[M", function()
						move.goto_previous_end("@function.outer", "textobjects")
					end)
					vim.keymap.set(mode, "]]", function()
						move.goto_next_start("@class.outer", "textobjects")
					end)
					vim.keymap.set(mode, "][", function()
						move.goto_next_end("@class.outer", "textobjects")
					end)
					vim.keymap.set(mode, "[[", function()
						move.goto_previous_start("@class.outer", "textobjects")
					end)
					vim.keymap.set(mode, "[]", function()
						move.goto_previous_end("@class.outer", "textobjects")
					end)
				end

				local swap = require("nvim-treesitter-textobjects.swap")
				vim.keymap.set("n", "<leader>a", function()
					swap.swap_next("@parameter.inner")
				end)
				vim.keymap.set("n", "<leader>A", function()
					swap.swap_previous("@parameter.inner")
				end)
			end,
		},
		{
			"windwp/nvim-ts-autotag",
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		},
	},
}
