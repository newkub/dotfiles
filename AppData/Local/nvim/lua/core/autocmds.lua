-- Autocommands for Neovim

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General settings
augroup("GeneralSettings", { clear = true })
-- autocmd("VimLeavePre", {
--   group = "GeneralSettings",
--   pattern = "*",
--   callback = function()
--     vim.cmd("silent! wa")
--   end,
-- })
-- autocmd("FocusLost", {
-- 	group = "GeneralSettings",
-- 	pattern = "*",
-- 	callback = function()
-- 		if vim.fn.expand("%") ~= "" then
-- 			vim.cmd("silent! wa")
-- 		end
-- 	end,
-- })
-- autocmd("TermClose", {
-- 	group = "GeneralSettings",
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.cmd("silent! wa")
-- 	end,
-- })

autocmd({ "FocusLost", "BufLeave", "VimLeavePre" }, {
	group = "GeneralSettings",
	pattern = "*",
	callback = function()
		local buftype = vim.bo.buftype
		if buftype ~= "" then
			return
		end
		if vim.fn.expand("%") == "" then
			return
		end
		vim.cmd("silent! wall")
	end,
})

-- Swap file management
augroup("SwapFileManagement", { clear = true })
autocmd("BufWritePre", {
	group = "SwapFileManagement",
	pattern = "*",
	callback = function()
		vim.opt_local.swapfile = false
	end,
})
autocmd("BufWritePost", {
	group = "SwapFileManagement",
	pattern = "*",
	callback = function()
		vim.opt_local.swapfile = true
	end,
})

-- Cursor position
augroup("CursorPosition", { clear = true })
autocmd("BufReadPost", {
	group = "CursorPosition",
	pattern = "*",
	callback = function()
		local bufname = vim.fn.bufname()
		if
			bufname ~= ""
			and not bufname:match("dashboard")
			and not bufname:match("alpha")
			and not bufname:match("NvimTree")
		then
			pcall(function()
				local line = vim.fn.line("'\"")
				local col = vim.fn.col("'\"")
				if line > 0 and line <= vim.fn.line("$") then
					vim.api.nvim_win_set_cursor(0, { line, math.max(col - 1, 0) })
				end
			end)
		end
	end,
})
autocmd("BufWritePre", {
	group = "CursorPosition",
	pattern = "*",
	callback = function()
		pcall(vim.cmd, "silent! mkview")
	end,
})
autocmd("BufWinEnter", {
	group = "CursorPosition",
	pattern = "*",
	callback = function()
		pcall(vim.cmd, "silent! loadview")
	end,
})

augroup("CodeiumTabAccept", { clear = true })
autocmd("User", {
	group = "CodeiumTabAccept",
	pattern = "VeryLazy",
	callback = function()
		vim.defer_fn(function()
			require("core.codeium").setup_tab_mapping()
		end, 80)
	end,
})
autocmd("InsertEnter", {
	group = "CodeiumTabAccept",
	pattern = "*",
	callback = function()
		vim.defer_fn(function()
			require("core.codeium").setup_tab_mapping()
		end, 80)
	end,
})

-- Insert mode on enter
augroup("InsertModeOnEnter", { clear = true })
autocmd("BufEnter", {
	group = "InsertModeOnEnter",
	pattern = "*",
	callback = function()
		-- ใช้ vim.schedule เพื่อหน่วงเวลาให้ buffer พร้อมก่อน
		vim.schedule(function()
			local bufname = vim.fn.bufname()
			local buftype = vim.bo.buftype
			-- เข้า insert mode เมื่อเปิดไฟล์ปกติเท่านั้น
			if
				buftype == ""
				and bufname ~= ""
				and not bufname:match("dashboard")
				and not bufname:match("alpha")
				and not bufname:match("NvimTree")
				and not bufname:match("term://")
			then
				-- เช็คว่ายังอยู่ใน normal mode
				if vim.fn.mode() == "n" then
					vim.cmd("startinsert")
				end
			end
		end)
	end,
})

-- Auto file picker
augroup("AutoFilePicker", { clear = true })

autocmd("VimEnter", {
	group = "AutoFilePicker",
	pattern = "*",
	once = true,
	callback = function()
		if vim.fn.argc() ~= 0 then
			return
		end
		return
	end,
})

autocmd("User", {
	group = "AutoFilePicker",
	pattern = "VeryLazy",
	once = true,
	callback = function()
		if vim.fn.argc() ~= 0 then
			return
		end

		local tries = 0
		local function open_picker()
			tries = tries + 1
			pcall(function()
				local ok_lazy, lazy = pcall(require, "lazy")
				if ok_lazy and lazy and type(lazy.load) == "function" then
					lazy.load({ plugins = { "snacks.nvim" } })
				end
			end)

			local ok_snacks, snacks = pcall(require, "snacks")
			if ok_snacks and snacks and snacks.picker and type(snacks.picker.files) == "function" then
				pcall(function()
					snacks.picker.files()
				end)
				return
			end
			if tries < 12 then
				vim.defer_fn(open_picker, 80)
			end
		end

		vim.defer_fn(open_picker, 120)
	end,
})

-- Terminal settings
augroup("TerminalSettings", { clear = true })
autocmd("TermOpen", {
	group = "TerminalSettings",
	pattern = "*",
	callback = function()
		-- ปิด line numbers ใน terminal
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"

		-- ตั้งค่าให้ terminal เข้า insert mode อัตโนมัติ
		vim.cmd("startinsert")
	end,
})

-- No normal mode
augroup("NoNormalMode", { clear = true })
autocmd("ModeChanged", {
	group = "NoNormalMode",
	pattern = "*",
	callback = function()
		local mode = vim.api.nvim_get_mode().mode
		if mode ~= "n" then
			return
		end
		local buftype = vim.bo.buftype
		local bufname = vim.fn.bufname()
		local ft = vim.bo.filetype
		if buftype ~= "" then
			return
		end
		if bufname == "" or bufname:match("dashboard") or bufname:match("alpha") then
			return
		end
		if ft == "snacks_explorer" or ft == "snacks_terminal" or ft == "trouble" or ft == "terminal" then
			return
		end
		vim.schedule(function()
			if vim.fn.mode() == "n" then
				vim.cmd("startinsert")
			end
		end)
	end,
})

autocmd("CmdlineLeave", {
	group = "NoNormalMode",
	pattern = ":",
	callback = function()
		vim.schedule(function()
			local ft = vim.bo.filetype
			if ft == "snacks_explorer" or ft == "snacks_terminal" or ft == "trouble" or ft == "terminal" then
				return
			end
			if vim.fn.mode() == "n" then
				vim.cmd("startinsert")
			end
		end)
	end,
})
