return {
	"Exafunction/windsurf.nvim",
	priority = 1001, -- สูงกว่า snacks (1000) เพื่อให้ load และ setup Tab key ก่อน
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = "InsertEnter",
	config = function()
		require("codeium").setup({
			enable_chat = true,
			virtual_text = {
				enabled = true,
				manual = false,
				idle_delay = 75,
				map_keys = false,
				key_bindings = {
					-- ใช้ custom mapping ใน lua/mappings/system.lua
					accept = false,
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					clear = "<C-]>",
				},
			},
		})

		-- ตั้งค่าเพิ่มเติมหลังจาก setup
		-- map_keys = true จะจัดการ Tab key ให้อัตโนมัติ
		-- Windsurf จะ check ก่อนว่ามี suggestion หรือไม่
		-- ถ้ามี suggestion จะ accept, ถ้าไม่มีจะปล่อยให้ Tab ทำงานปกติ
	end,
}
