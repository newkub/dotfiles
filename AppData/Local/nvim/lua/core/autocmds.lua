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
		local function open_file_picker()
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
				vim.defer_fn(open_file_picker, 80)
			end
		end

		vim.defer_fn(open_file_picker, 120)
	end,
})

-- Auto open explorer sidebar on the left when entering a real file
augroup("AutoExplorer", { clear = true })
autocmd("BufEnter", {
	group = "AutoExplorer",
	pattern = "*",
	callback = function(args)
		if vim.bo[args.buf].buftype ~= "" then
			return
		end
		local path = vim.api.nvim_buf_get_name(args.buf)
		if path == "" then
			return
		end
		if path:match("^%w+://") then
			return
		end
		pcall(function()
			local snacks = require("snacks")
			if not (snacks.explorer and snacks.picker and type(snacks.explorer.reveal) == "function") then
				return
			end
			-- Open explorer on the left without stealing focus, then reveal the current file
			local pickers = snacks.picker.get({ source = "explorer" })
			if not pickers or #pickers == 0 then
				snacks.picker.explorer({ focus = false })
			end
			snacks.explorer.reveal({ file = path })
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


