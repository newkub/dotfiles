return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = {
      -- your bigfile configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    dashboard = { 
      enabled = true,
      sections = {
        { section = "header" },
        {
          pane = 2,
          section = "terminal",
          cmd = "ver",
          height = 5,
          padding = 1,
        },
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
          }
        },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
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
    dim = {
      -- your dim configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    explorer = { enabled = true },
    gitbrowse = {
      -- your gitbrowse configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    image = {
      -- your image configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    indent = { enabled = true },
    input = {
      -- your input configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = { 
      enabled = true,
      -- Add error handling for picker actions
      hooks = {
        -- Handle errors in picker actions
        on_error = function(err)
          vim.notify("Picker error: " .. tostring(err), vim.log.levels.ERROR)
        end
      }
    },
    profiler = {
      -- your profiler configuration comes here
      -- or leave it empty to use the default settings
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = {
      -- your scroll configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    statuscolumn = { 
      enabled = true,
      git = {
        enabled = true,
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "┆" },
        },
      },
    },
    terminal = {
      -- your terminal configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      }
    }
  },
  keys = {
    -- Top Pickers & Explorer
    { "<leader><space>", function() 
          -- Toggle behavior instead of opening smart picker
          local status, err = pcall(function()
            -- Check if we're on dashboard already
            local bufname = vim.fn.bufname()
            if bufname:match("dashboard") or bufname:match("alpha") then
              -- If on dashboard, go to last buffer or create new one
              vim.cmd("b#")
            else
              -- If not on dashboard, go to dashboard
              require("snacks").dashboard()
            end
          end)
          if not status then
            vim.notify("Error toggling dashboard: " .. tostring(err), vim.log.levels.ERROR)
          end
        end, desc = "Toggle Dashboard" },
    { "<leader>,", function() 
        local status, err = pcall(function()
          require("snacks").picker.buffers()
        end)
        if not status then
          vim.notify("Error opening buffers picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Buffers" },
    { "<leader>/", function() 
        local status, err = pcall(function()
          require("snacks").picker.grep()
        end)
        if not status then
          vim.notify("Error opening grep picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Grep" },
    { "<leader>:", function() 
        local status, err = pcall(function()
          require("snacks").picker.command_history()
        end)
        if not status then
          vim.notify("Error opening command history: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Command History" },
    { "<leader>n", function() 
        local status, err = pcall(function()
          require("snacks").picker.notifications()
        end)
        if not status then
          vim.notify("Error opening notifications: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Notification History" },
    { "<leader>e", function() 
        local status, err = pcall(function()
          require("snacks").explorer()
        end)
        if not status then
          vim.notify("Error opening explorer: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "File Explorer" },
    { "<C-p>", function() 
        local status, err = pcall(function()
          require("snacks").picker.smart()
        end)
        if not status then
          vim.notify("Error opening smart file picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Smart File Picker" },
    { "<C-S-f>", function() 
        local status, err = pcall(function()
          require("snacks").picker.files()
        end)
        if not status then
          vim.notify("Error opening file picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "File Picker" },
    { "<S-f>", function() 
        local status, err = pcall(function()
          require("snacks").picker.files()
        end)
        if not status then
          vim.notify("Error opening file picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "File Picker" },
    { "<C-f>", function() 
        local status, err = pcall(function()
          require("snacks").picker.grep()
        end)
        if not status then
          vim.notify("Error opening grep picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Grep in Files" },
    -- find
    { "<leader>fb", function() 
        local status, err = pcall(function()
          require("snacks").picker.buffers()
        end)
        if not status then
          vim.notify("Error opening buffers picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Buffers" },
    { "<leader>fc", function() 
        local status, err = pcall(function()
          require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
        end)
        if not status then
          vim.notify("Error opening config file picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Find Config File" },
    { "<leader>ff", function() 
        local status, err = pcall(function()
          require("snacks").picker.files()
        end)
        if not status then
          vim.notify("Error opening file picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Find Files" },
    { "<leader>fg", function() 
        local status, err = pcall(function()
          require("snacks").picker.git_files()
        end)
        if not status then
          vim.notify("Error opening git files picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Find Git Files" },
    { "<leader>fp", function() 
        local status, err = pcall(function()
          require("snacks").picker.projects()
        end)
        if not status then
          vim.notify("Error opening projects picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Projects" },
    { "<leader>fr", function() 
        local status, err = pcall(function()
          require("snacks").picker.recent()
        end)
        if not status then
          vim.notify("Error opening recent files picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Recent" },
    -- git
    { "<leader>gb", function() 
        local status, err = pcall(function()
          require("snacks").picker.git_branches()
        end)
        if not status then
          vim.notify("Error opening git branches picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Git Branches" },
    { "<leader>gl", function() 
        local status, err = pcall(function()
          require("snacks").picker.git_log()
        end)
        if not status then
          vim.notify("Error opening git log picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Git Log" },
    { "<leader>gL", function() 
        local status, err = pcall(function()
          require("snacks").picker.git_log_line()
        end)
        if not status then
          vim.notify("Error opening git log line picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Git Log Line" },
    { "<leader>gs", function() 
        local status, err = pcall(function()
          require("snacks").picker.git_status()
        end)
        if not status then
          vim.notify("Error opening git status picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Git Status" },
    { "<leader>gS", function() 
        local status, err = pcall(function()
          require("snacks").picker.git_stash()
        end)
        if not status then
          vim.notify("Error opening git stash picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Git Stash" },
    { "<leader>gd", function() 
        local status, err = pcall(function()
          require("snacks").picker.git_diff()
        end)
        if not status then
          vim.notify("Error opening git diff picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Git Diff (Hunks) " },
    { "<leader>gf", function() 
        local status, err = pcall(function()
          require("snacks").picker.git_log_file()
        end)
        if not status then
          vim.notify("Error opening git log file picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Git Log File" },
    -- Grep
    { "<leader>sb", function() 
        local status, err = pcall(function()
          require("snacks").picker.lines()
        end)
        if not status then
          vim.notify("Error opening lines picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Buffer Lines" },
    { "<leader>sB", function() 
        local status, err = pcall(function()
          require("snacks").picker.grep_buffers()
        end)
        if not status then
          vim.notify("Error opening grep buffers picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Grep Open Buffers" },
    { "<leader>sg", function() 
        local status, err = pcall(function()
          require("snacks").picker.grep()
        end)
        if not status then
          vim.notify("Error opening grep picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Grep" },
    { "<leader>sw", function() 
        local status, err = pcall(function()
          require("snacks").picker.grep_word()
        end)
        if not status then
          vim.notify("Error opening grep word picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Visual selection or word", mode = { "n", "x" } },
    -- search
    { '<leader>s"', function() 
        local status, err = pcall(function()
          require("snacks").picker.registers()
        end)
        if not status then
          vim.notify("Error opening registers picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Registers" },
    { '<leader>s/', function() 
        local status, err = pcall(function()
          require("snacks").picker.search_history()
        end)
        if not status then
          vim.notify("Error opening search history picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Search History" },
    { "<leader>sa", function() 
        local status, err = pcall(function()
          require("snacks").picker.autocmds()
        end)
        if not status then
          vim.notify("Error opening autocommands picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Autocmds" },
    { "<leader>sb", function() 
        local status, err = pcall(function()
          require("snacks").picker.lines()
        end)
        if not status then
          vim.notify("Error opening lines picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Buffer Lines" },
    { "<leader>sc", function() 
        local status, err = pcall(function()
          require("snacks").picker.command_history()
        end)
        if not status then
          vim.notify("Error opening command history picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Command History" },
    { "<leader>sC", function() 
        local status, err = pcall(function()
          require("snacks").picker.commands()
        end)
        if not status then
          vim.notify("Error opening commands picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Commands" },
    { "<leader>sd", function() 
        local status, err = pcall(function()
          require("snacks").picker.diagnostics()
        end)
        if not status then
          vim.notify("Error opening diagnostics picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Diagnostics" },
    { "<leader>sD", function() 
        local status, err = pcall(function()
          require("snacks").picker.diagnostics_buffer()
        end)
        if not status then
          vim.notify("Error opening buffer diagnostics picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Buffer Diagnostics" },
    { "<leader>sh", function() 
        local status, err = pcall(function()
          require("snacks").picker.help()
        end)
        if not status then
          vim.notify("Error opening help picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Help Pages" },
    { "<leader>sH", function() 
        local status, err = pcall(function()
          require("snacks").picker.highlights()
        end)
        if not status then
          vim.notify("Error opening highlights picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Highlights" },
    { "<leader>si", function() 
        local status, err = pcall(function()
          require("snacks").picker.icons()
        end)
        if not status then
          vim.notify("Error opening icons picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Icons" },
    { "<leader>sj", function() 
        local status, err = pcall(function()
          require("snacks").picker.jumps()
        end)
        if not status then
          vim.notify("Error opening jumps picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Jumps" },
    { "<leader>sk", function() 
        local status, err = pcall(function()
          require("snacks").picker.keymaps()
        end)
        if not status then
          vim.notify("Error opening keymaps picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Keymaps" },
    { "<leader>sl", function() 
        local status, err = pcall(function()
          require("snacks").picker.loclist()
        end)
        if not status then
          vim.notify("Error opening location list picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Location List" },
    { "<leader>sm", function() 
        local status, err = pcall(function()
          require("snacks").picker.marks()
        end)
        if not status then
          vim.notify("Error opening marks picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Marks" },
    { "<leader>sM", function() 
        local status, err = pcall(function()
          require("snacks").picker.man()
        end)
        if not status then
          vim.notify("Error opening man pages picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Man Pages" },
    { "<leader>sp", function() 
        local status, err = pcall(function()
          require("snacks").picker.lazy()
        end)
        if not status then
          vim.notify("Error opening lazy picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Search for Plugin Spec" },
    { "<leader>sq", function() 
        local status, err = pcall(function()
          require("snacks").picker.qflist()
        end)
        if not status then
          vim.notify("Error opening quickfix list picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Quickfix List" },
    { "<leader>sR", function() 
        local status, err = pcall(function()
          require("snacks").picker.resume()
        end)
        if not status then
          vim.notify("Error opening resume picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Resume" },
    { "<leader>su", function() 
        local status, err = pcall(function()
          require("snacks").picker.undo()
        end)
        if not status then
          vim.notify("Error opening undo history picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Undo History" },
    { "<leader>uC", function() 
        local status, err = pcall(function()
          require("snacks").picker.colorschemes()
        end)
        if not status then
          vim.notify("Error opening colorschemes picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Colorschemes" },
    -- Profiler mappings
    { "<leader>pp", function() 
        local status, err = pcall(function()
          require("snacks").toggle.profiler()
        end)
        if not status then
          vim.notify("Error toggling profiler: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Toggle Profiler" },
    { "<leader>ph", function() 
        local status, err = pcall(function()
          require("snacks").toggle.profiler_highlights()
        end)
        if not status then
          vim.notify("Error toggling profiler highlights: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Toggle Profiler Highlights" },
    { "<leader>ps", function() 
        local status, err = pcall(function()
          require("snacks").profiler.scratch()
        end)
        if not status then
          vim.notify("Error opening profiler scratch buffer: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Profiler Scratch Buffer" },
    -- Mason
    { "<leader>pm", function() 
        local status, err = pcall(function()
          vim.cmd("Mason")
        end)
        if not status then
          vim.notify("Error opening Mason: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Open Mason Dashboard" },
    -- LSP
    { "gd", function() 
        local status, err = pcall(function()
          require("snacks").picker.lsp_definitions()
        end)
        if not status then
          vim.notify("Error opening LSP definitions picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Goto Definition" },
    { "gD", function() 
        local status, err = pcall(function()
          require("snacks").picker.lsp_declarations()
        end)
        if not status then
          vim.notify("Error opening LSP declarations picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Goto Declaration" },
    { "gr", function() 
        local status, err = pcall(function()
          require("snacks").picker.lsp_references()
        end)
        if not status then
          vim.notify("Error opening LSP references picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, nowait = true, desc = "References" },
    { "gI", function() 
        local status, err = pcall(function()
          require("snacks").picker.lsp_implementations()
        end)
        if not status then
          vim.notify("Error opening LSP implementations picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Goto Implementation" },
    { "gy", function() 
        local status, err = pcall(function()
          require("snacks").picker.lsp_type_definitions()
        end)
        if not status then
          vim.notify("Error opening LSP type definitions picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Goto T[y]pe Definition" },
    { "<leader>ss", function() 
        local status, err = pcall(function()
          require("snacks").picker.lsp_symbols()
        end)
        if not status then
          vim.notify("Error opening LSP symbols picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "LSP Symbols" },
    { "<leader>sS", function() 
        local status, err = pcall(function()
          require("snacks").picker.lsp_workspace_symbols()
        end)
        if not status then
          vim.notify("Error opening LSP workspace symbols picker: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "LSP Workspace Symbols" },
    -- Other
    { "<leader>z",  function() 
        local status, err = pcall(function()
          require("snacks").zen()
        end)
        if not status then
          vim.notify("Error toggling zen mode: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Toggle Zen Mode" },
    { "<leader>Z",  function() 
        local status, err = pcall(function()
          require("snacks").zen.zoom()
        end)
        if not status then
          vim.notify("Error toggling zoom: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Toggle Zoom" },
    { "<leader>.",  function() 
        local status, err = pcall(function()
          require("snacks").scratch()
        end)
        if not status then
          vim.notify("Error toggling scratch buffer: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() 
        local status, err = pcall(function()
          require("snacks").scratch.select()
        end)
        if not status then
          vim.notify("Error selecting scratch buffer: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Select Scratch Buffer" },
    { "<leader>n",  function() 
        local status, err = pcall(function()
          require("snacks").notifier.show_history()
        end)
        if not status then
          vim.notify("Error showing notification history: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Notification History" },
    { "<leader>bd", function() 
        local status, err = pcall(function()
          require("snacks").bufdelete()
        end)
        if not status then
          vim.notify("Error deleting buffer: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Delete Buffer" },
    { "<leader>cR", function() 
        local status, err = pcall(function()
          require("snacks").rename.rename_file()
        end)
        if not status then
          vim.notify("Error renaming file: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Rename File" },
    { "<leader>gB", function() 
        local status, err = pcall(function()
          require("snacks").gitbrowse()
        end)
        if not status then
          vim.notify("Error browsing git: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Git Browse", mode = { "n", "v" } },
    { "<leader>un", function() 
        local status, err = pcall(function()
          require("snacks").notifier.hide()
        end)
        if not status then
          vim.notify("Error hiding notifications: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Dismiss All Notifications" },
    { "<c-/>",      function() 
        local status, err = pcall(function()
          require("snacks").terminal()
        end)
        if not status then
          vim.notify("Error toggling terminal: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Toggle Terminal" },
    { "<c-_>",      function() 
        local status, err = pcall(function()
          require("snacks").terminal()
        end)
        if not status then
          vim.notify("Error toggling terminal: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Toggle Terminal" },
    { "]]",         function() 
        local status, err = pcall(function()
          require("snacks").words.jump(vim.v.count1)
        end)
        if not status then
          vim.notify("Error jumping to next reference: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[",         function() 
        local status, err = pcall(function()
          require("snacks").words.jump(-vim.v.count1)
        end)
        if not status then
          vim.notify("Error jumping to previous reference: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, desc = "Prev Reference", mode = { "n", "t" } },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        local status, err = pcall(function()
          require("snacks").win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end)
        if not status then
          vim.notify("Error opening Neovim news: " .. tostring(err), vim.log.levels.ERROR)
        end
      end,
    }
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          local status, result = pcall(function(...)
            require("snacks").debug.inspect(...)
          end, ...)
          if not status then
            vim.notify("Error in debug.inspect: " .. tostring(result), vim.log.levels.ERROR)
          end
        end
        _G.bt = function()
          local status, result = pcall(function()
            require("snacks").debug.backtrace()
          end)
          if not status then
            vim.notify("Error in debug.backtrace: " .. tostring(result), vim.log.levels.ERROR)
          end
        end

        -- Override print to use snacks for `:=` command
        if vim.fn.has("nvim-0.11") == 1 then
          vim._print = function(_, ...)
            local status, result = pcall(function(...)
              dd(...)
            end, ...)
            if not status then
              vim.notify("Error in print override: " .. tostring(result), vim.log.levels.ERROR)
            end
          end
        else
          vim.print = _G.dd 
        end

        -- Create some toggle mappings
        local function safe_toggle(toggle_fn, name)
          return function()
            local status, result = pcall(toggle_fn)
            if not status then
              vim.notify("Error toggling " .. name .. ": " .. tostring(result), vim.log.levels.ERROR)
            end
          end
        end

        local snacks_status, snacks = pcall(require, "snacks")
        if snacks_status then
          snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          snacks.toggle.diagnostics():map("<leader>ud")
          snacks.toggle.line_number():map("<leader>ul")
          snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
          snacks.toggle.treesitter():map("<leader>uT")
          snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          snacks.toggle.inlay_hints():map("<leader>uh")
          snacks.toggle.indent():map("<leader>ug")
          snacks.toggle.dim():map("<leader>uD")
          -- Initialize profiler toggles
          snacks.toggle.profiler():map("<leader>pp")
          snacks.toggle.profiler_highlights():map("<leader>ph")
        else
          vim.notify("Error loading snacks for toggle mappings: " .. tostring(snacks), vim.log.levels.ERROR)
        end
      end,
    })
    
    -- Add buffer validation to prevent invalid buffer errors
    vim.api.nvim_create_autocmd("BufWinEnter", {
      pattern = "*",
      callback = function()
        -- Validate buffer exists before any operations
        local bufnr = vim.api.nvim_get_current_buf()
        if not vim.api.nvim_buf_is_valid(bufnr) then
          return
        end
      end,
    })
    
    -- Enable sign column for Git signs
    vim.opt.signcolumn = "yes"
    
    -- Autocommand to ensure we exit insert mode on dashboard
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      callback = function()
        local bufname = vim.fn.bufname()
        if bufname:match("dashboard") or bufname:match("alpha") then
          -- Ensure we're in normal mode on dashboard
          vim.cmd("stopinsert")
        end
      end,
    })
  end,
}