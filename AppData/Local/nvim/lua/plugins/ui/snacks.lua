-- Snacks plugin configuration and initialization

local function safe_call(fn, error_msg)
	return function()
		local status, err = pcall(fn)
		if not status then
			vim.notify(error_msg .. ": " .. tostring(err), vim.log.levels.ERROR)
		end
	end
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	event = "VimEnter",
	opts = {
		-- Options from config.lua
		bigfile = {},
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ pane = 2, section = "terminal", cmd = "ver", height = 5, padding = 1 },
				{
					section = "keys",
					gap = 1,
					padding = 1,
					keys = {
						{ "f", "<cmd>lua require('snacks').picker.files()<cr>", "Find File" },
						{ "n", "<cmd>enew<cr>", "New File" },
						{ "p", "<cmd>lua require('snacks').picker.projects()<cr>", "Projects" },
						{ "g", "<cmd>lua require('snacks').picker.git_files()<cr>", "Git Files" },
						{ "r", "<cmd>lua require('snacks').picker.recent()<cr>", "Recent Files" },
					},
				},
				{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{
					pane = 2,
					icon = " ",
					title = "Git Status",
					section = "terminal",
					enabled = function()
						local status, result = pcall(function()
							return require("snacks").git.get_root() ~= nil
						end)
						return status and result
					end,
					cmd = "git status --short --branch --renames",
					height = 5,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
				},
				{ section = "startup" },
			},
		},
		dim = {},
		explorer = { enabled = true },
		gitbrowse = {},
		image = {},
		indent = { enabled = false },
		input = {},
		notifier = { enabled = true, timeout = 3000 },
		picker = {
			enabled = true,
			ui = "snacks",
			sources = {
				files = { hidden = true, follow = true },
			},
			hooks = {
				on_error = function(err)
					vim.notify("Picker error: " .. tostring(err), vim.log.levels.ERROR)
				end,
			},
			win = {
				input = {
					keys = {
						["<C-p>"] = { "picker_files", mode = { "n", "i" } },
						["<C-r>"] = { "picker_recent", mode = { "n", "i" } },
						["<Esc>"] = { "close", mode = { "n", "i" } },
						["<C-c>"] = { "close", mode = { "n", "i" } },
					},
				},
				list = {
					keys = {
						["<Esc>"] = { "close", mode = { "n", "i" } },
						["<C-c>"] = { "close", mode = { "n", "i" } },
					},
				},
				preview = {
					keys = {
						["<Esc>"] = { "close", mode = { "n", "i" } },
						["<C-c>"] = { "close", mode = { "n", "i" } },
					},
				},
			},
		},
		profiler = {},
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = {},
		statuscolumn = {
			enabled = true,
			git = {
				enabled = true,
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
					untracked = { text = "┆" },
				},
			},
		},
		terminal = {
			win = {
				style = "terminal",
			},
			shell = require("core.utils").get_default_shell(),
		},
		words = { enabled = true },
		styles = {
			notification = {},
		},
	},
	keys = {
		-- Keybindings from keys.lua
		{
			"<leader><space>",
			safe_call(function()
				if vim.fn.bufname():match("dashboard") or vim.fn.bufname():match("alpha") then
					vim.cmd("b#")
				else
					require("snacks").dashboard()
				end
			end, "Error toggling dashboard"),
			desc = "Toggle Dashboard",
			mode = "n",
		},
		{
			"<leader>,",
			safe_call(function()
				require("snacks").picker.buffers()
			end, "Error opening buffers picker"),
			desc = "Buffers",
		},
		{
			"<leader>/",
			safe_call(function()
				require("snacks").picker.grep()
			end, "Error opening grep picker"),
			desc = "Grep",
		},
		{
			"<leader>:",
			safe_call(function()
				require("snacks").picker.command_history()
			end, "Error opening command history"),
			desc = "Command History",
		},
		{
			"<leader>n",
			safe_call(function()
				require("snacks").picker.notifications()
			end, "Error opening notifications"),
			desc = "Notification History",
		},
		{
			"<leader>e",
			safe_call(function()
				require("snacks").explorer()
			end, "Error opening explorer"),
			desc = "File Explorer",
		},
		{
			"<C-p>",
			safe_call(function()
				require("snacks").picker.files()
			end, "Error opening file picker"),
			desc = "File Picker",
		},
		{
			"<C-r>",
			safe_call(function()
				require("snacks").picker.recent()
			end, "Error opening recent files picker"),
			desc = "Recent Files",
		},
		{
			"<C-S-f>",
			safe_call(function()
				require("snacks").picker.files()
			end, "Error opening file picker"),
			desc = "File Picker",
		},
		{
			"<S-f>",
			safe_call(function()
				require("snacks").picker.files()
			end, "Error opening file picker"),
			desc = "File Picker",
		},
		{
			"<C-f>",
			safe_call(function()
				require("snacks").picker.grep()
			end, "Error opening grep picker"),
			desc = "Grep in Files",
		},
		{
			"<leader>fb",
			safe_call(function()
				require("snacks").picker.buffers()
			end, "Error opening buffers picker"),
			desc = "Buffers",
		},
		{
			"<leader>fc",
			safe_call(function()
				require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
			end, "Error opening config file picker"),
			desc = "Find Config File",
		},
		{
			"<leader>ff",
			safe_call(function()
				require("snacks").picker.files()
			end, "Error opening file picker"),
			desc = "Find Files",
		},
		{
			"<leader>fg",
			safe_call(function()
				require("snacks").picker.git_files()
			end, "Error opening git files picker"),
			desc = "Find Git Files",
		},
		{
			"<leader>fp",
			safe_call(function()
				require("snacks").picker.projects()
			end, "Error opening projects picker"),
			desc = "Projects",
		},
		{
			"<leader>fr",
			safe_call(function()
				require("snacks").picker.recent()
			end, "Error opening recent files picker"),
			desc = "Recent",
		},
		{
			"<leader>gb",
			safe_call(function()
				require("snacks").picker.git_branches()
			end, "Error opening git branches picker"),
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			safe_call(function()
				require("snacks").picker.git_log()
			end, "Error opening git log picker"),
			desc = "Git Log",
		},
		{
			"<leader>gL",
			safe_call(function()
				require("snacks").picker.git_log_line()
			end, "Error opening git log line picker"),
			desc = "Git Log Line",
		},
		{
			"<leader>gs",
			safe_call(function()
				require("snacks").picker.git_status()
			end, "Error opening git status picker"),
			desc = "Git Status",
		},
		{
			"<leader>gS",
			safe_call(function()
				require("snacks").picker.git_stash()
			end, "Error opening git stash picker"),
			desc = "Git Stash",
		},
		{
			"<leader>gd",
			safe_call(function()
				require("snacks").picker.git_diff()
			end, "Error opening git diff picker"),
			desc = "Git Diff (Hunks)",
		},
		{
			"<leader>gf",
			safe_call(function()
				require("snacks").picker.git_log_file()
			end, "Error opening git log file picker"),
			desc = "Git Log File",
		},
		{
			"<leader>sb",
			safe_call(function()
				require("snacks").picker.lines()
			end, "Error opening lines picker"),
			desc = "Buffer Lines",
		},
		{
			"<leader>sB",
			safe_call(function()
				require("snacks").picker.grep_buffers()
			end, "Error opening grep buffers picker"),
			desc = "Grep Open Buffers",
		},
		{
			"<leader>sg",
			safe_call(function()
				require("snacks").picker.grep()
			end, "Error opening grep picker"),
			desc = "Grep",
		},
		{
			"<leader>sw",
			safe_call(function()
				require("snacks").picker.grep_word()
			end, "Error opening grep word picker"),
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		{
			'<leader>s"',
			safe_call(function()
				require("snacks").picker.registers()
			end, "Error opening registers picker"),
			desc = "Registers",
		},
		{
			"<leader>s/",
			safe_call(function()
				require("snacks").picker.search_history()
			end, "Error opening search history picker"),
			desc = "Search History",
		},
		{
			"<leader>sa",
			safe_call(function()
				require("snacks").picker.autocmds()
			end, "Error opening autocmds picker"),
			desc = "Autocmds",
		},
		{
			"<leader>sc",
			safe_call(function()
				require("snacks").picker.command_history()
			end, "Error opening command history picker"),
			desc = "Command History",
		},
		{
			"<leader>sC",
			safe_call(function()
				require("snacks").picker.commands()
			end, "Error opening commands picker"),
			desc = "Commands",
		},
		{
			"<leader>sd",
			safe_call(function()
				require("snacks").picker.diagnostics()
			end, "Error opening diagnostics picker"),
			desc = "Diagnostics",
		},
		{
			"<leader>sD",
			safe_call(function()
				require("snacks").picker.diagnostics_buffer()
			end, "Error opening buffer diagnostics picker"),
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>sh",
			safe_call(function()
				require("snacks").picker.help()
			end, "Error opening help picker"),
			desc = "Help Pages",
		},
		{
			"<leader>sH",
			safe_call(function()
				require("snacks").picker.highlights()
			end, "Error opening highlights picker"),
			desc = "Highlights",
		},
		{
			"<leader>si",
			safe_call(function()
				require("snacks").picker.icons()
			end, "Error opening icons picker"),
			desc = "Icons",
		},
		{
			"<leader>sj",
			safe_call(function()
				require("snacks").picker.jumps()
			end, "Error opening jumps picker"),
			desc = "Jumps",
		},
		{
			"<leader>sk",
			safe_call(function()
				require("snacks").picker.keymaps()
			end, "Error opening keymaps picker"),
			desc = "Keymaps",
		},
		{
			"<leader>sl",
			safe_call(function()
				require("snacks").picker.loclist()
			end, "Error opening location list picker"),
			desc = "Location List",
		},
		{
			"<leader>sm",
			safe_call(function()
				require("snacks").picker.marks()
			end, "Error opening marks picker"),
			desc = "Marks",
		},
		{
			"<leader>sM",
			safe_call(function()
				require("snacks").picker.man()
			end, "Error opening man pages picker"),
			desc = "Man Pages",
		},
		{
			"<leader>sp",
			safe_call(function()
				require("snacks").picker.lazy()
			end, "Error opening lazy picker"),
			desc = "Search for Plugin Spec",
		},
		{
			"<leader>sq",
			safe_call(function()
				require("snacks").picker.qflist()
			end, "Error opening quickfix list picker"),
			desc = "Quickfix List",
		},
		{
			"<leader>sR",
			safe_call(function()
				require("snacks").picker.resume()
			end, "Error opening resume picker"),
			desc = "Resume",
		},
		{
			"<leader>su",
			safe_call(function()
				require("snacks").picker.undo()
			end, "Error opening undo history picker"),
			desc = "Undo History",
		},
		{
			"<leader>uC",
			safe_call(function()
				require("snacks").picker.colorschemes()
			end, "Error opening colorschemes picker"),
			desc = "Colorschemes",
		},
		{
			"<leader>pp",
			safe_call(function()
				require("snacks").toggle.profiler()
			end, "Error toggling profiler"),
			desc = "Toggle Profiler",
		},
		{
			"<leader>ph",
			safe_call(function()
				require("snacks").toggle.profiler_highlights()
			end, "Error toggling profiler highlights"),
			desc = "Toggle Profiler Highlights",
		},
		{
			"<leader>ps",
			safe_call(function()
				require("snacks").profiler.scratch()
			end, "Error opening profiler scratch buffer"),
			desc = "Profiler Scratch Buffer",
		},
		{
			"<leader>pm",
			safe_call(function()
				vim.cmd("Mason")
			end, "Error opening Mason"),
			desc = "Open Mason Dashboard",
		},
		{
			"gd",
			safe_call(function()
				require("snacks").picker.lsp_definitions()
			end, "Error opening LSP definitions picker"),
			desc = "Goto Definition",
		},
		{
			"gD",
			safe_call(function()
				require("snacks").picker.lsp_declarations()
			end, "Error opening LSP declarations picker"),
			desc = "Goto Declaration",
		},
		{
			"gr",
			safe_call(function()
				require("snacks").picker.lsp_references()
			end, "Error opening LSP references picker"),
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			safe_call(function()
				require("snacks").picker.lsp_implementations()
			end, "Error opening LSP implementations picker"),
			desc = "Goto Implementation",
		},
		{
			"gy",
			safe_call(function()
				require("snacks").picker.lsp_type_definitions()
			end, "Error opening LSP type definitions picker"),
			desc = "Goto T[y]pe Definition",
		},
		{
			"<leader>ss",
			safe_call(function()
				require("snacks").picker.lsp_symbols()
			end, "Error opening LSP symbols picker"),
			desc = "LSP Symbols",
		},
		{
			"<leader>sS",
			safe_call(function()
				require("snacks").picker.lsp_workspace_symbols()
			end, "Error opening LSP workspace symbols picker"),
			desc = "LSP Workspace Symbols",
		},
		{
			"<leader>z",
			safe_call(function()
				require("snacks").zen()
			end, "Error toggling zen mode"),
			desc = "Toggle Zen Mode",
		},
		{
			"<leader>Z",
			safe_call(function()
				require("snacks").zen.zoom()
			end, "Error toggling zoom"),
			desc = "Toggle Zoom",
		},
		{
			"<leader>.",
			safe_call(function()
				require("snacks").scratch()
			end, "Error toggling scratch buffer"),
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			safe_call(function()
				require("snacks").scratch.select()
			end, "Error selecting scratch buffer"),
			desc = "Select Scratch Buffer",
		},
		{
			"<leader>n",
			safe_call(function()
				require("snacks").notifier.show_history()
			end, "Error showing notification history"),
			desc = "Notification History",
		},
		{
			"<leader>bd",
			safe_call(function()
				require("snacks").bufdelete()
			end, "Error deleting buffer"),
			desc = "Delete Buffer",
		},
		{
			"<leader>cR",
			safe_call(function()
				require("snacks").rename.rename_file()
			end, "Error renaming file"),
			desc = "Rename File",
		},
		{
			"<leader>gB",
			safe_call(function()
				require("snacks").gitbrowse()
			end, "Error browsing git"),
			desc = "Git Browse",
			mode = { "n", "v" },
		},
		{
			"<leader>un",
			safe_call(function()
				require("snacks").notifier.hide()
			end, "Error hiding notifications"),
			desc = "Dismiss All Notifications",
		},
		{
			"<c-/>",
			safe_call(function()
				require("snacks").terminal()
			end, "Error toggling terminal"),
			desc = "Toggle Terminal",
		},
		{
			"<c-_>",
			safe_call(function()
				require("snacks").terminal()
			end, "Error toggling terminal"),
			desc = "Toggle Terminal",
		},
		{
			"][",
			safe_call(function()
				require("snacks").words.jump(vim.v.count1)
			end, "Error jumping to next reference"),
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			safe_call(function()
				require("snacks").words.jump(-vim.v.count1)
			end, "Error jumping to previous reference"),
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
		{
			"<leader>N",
			desc = "Neovim News",
			safe_call(function()
				require("snacks").win({
					file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
					width = 0.6,
					height = 0.6,
					wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3 },
				})
			end, "Error opening Neovim news"),
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup globals for debugging
				_G.dd = function(...)
					pcall(require("snacks").debug.inspect, ...)
				end
				_G.bt = function()
					pcall(require("snacks").debug.backtrace)
				end

				-- Override print to use snacks
				if vim.fn.has("nvim-0.11") == 1 then
					vim._print = function(_, ...)
						pcall(dd, ...)
					end
				else
					vim.print = _G.dd
				end

				-- Create toggle mappings
				local snacks = require("snacks")
				snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				snacks.toggle.diagnostics():map("<leader>ud")
				snacks.toggle.line_number():map("<leader>ul")
				snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				snacks.toggle.treesitter():map("<leader>uT")
				snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>ub")
				snacks.toggle.inlay_hints():map("<leader>uh")
				snacks.toggle.indent():map("<leader>ug")
				snacks.toggle.dim():map("<leader>uD")
				snacks.toggle.profiler():map("<leader>pp")
				snacks.toggle.profiler_highlights():map("<leader>ph")
			end,
		})

		-- Buffer validation
		vim.api.nvim_create_autocmd("BufWinEnter", {
			pattern = "*",
			callback = function()
				local bufnr = vim.api.nvim_get_current_buf()
				if not vim.api.nvim_buf_is_valid(bufnr) then
					return
				end
			end,
		})

		-- Enable sign column
		vim.opt.signcolumn = "yes"

		-- Exit insert mode on dashboard
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "*",
			callback = function()
				local bufname = vim.fn.bufname()
				if bufname:match("dashboard") or bufname:match("alpha") then
					vim.cmd("stopinsert")
				end
			end,
		})
	end,
}
