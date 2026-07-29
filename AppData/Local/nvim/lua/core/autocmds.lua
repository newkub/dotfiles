-- Autocommands for Neovim

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function is_normal_buffer(bufnr)
	bufnr = bufnr or 0
	if vim.bo[bufnr].buftype ~= "" then
		return false
	end
	if vim.api.nvim_buf_get_name(bufnr) == "" then
		return false
	end
	return true
end

local function is_excluded_bufname(bufname)
	if bufname == "" then
		return true
	end
	if bufname:match("dashboard") or bufname:match("alpha") or bufname:match("NvimTree") then
		return true
	end
	return false
end

local function is_excluded_filetype(ft)
	return ft == "snacks_explorer" or ft == "snacks_terminal" or ft == "trouble" or ft == "terminal"
end

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
		if not is_normal_buffer() then
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
		if not is_excluded_bufname(bufname) then
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
	callback = function(args)
		if not is_normal_buffer(args.buf) then
			return
		end
		pcall(vim.cmd, "silent! mkview")
	end,
})
autocmd("BufWinEnter", {
	group = "CursorPosition",
	pattern = "*",
	callback = function(args)
		if not is_normal_buffer(args.buf) then
			return
		end
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

-- Auto open explorer sidebar once when starting Neovim with a real file
augroup("AutoExplorer", { clear = true })
autocmd("VimEnter", {
	group = "AutoExplorer",
	pattern = "*",
	once = true,
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		if not is_normal_buffer(buf) then
			return
		end
		pcall(function()
			require("snacks").explorer({ focus = false })
		end)
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


