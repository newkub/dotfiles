# NvChad Custom Configuration

This repository contains my personal Neovim configuration built on top of NvChad. It provides a customized setup while leveraging NvChad's powerful features and optimizations.

## Overview

**This repo is meant to be used as a custom config by NvChad users!**

- The main NvChad repository (NvChad/NvChad) is used as a plugin by this configuration
- You can import NvChad modules using `require "nvchad.options"`, `require "nvchad.mappings"`, etc.
- This setup allows for easy customization while maintaining NvChad's core functionality

## Installation

1. First, ensure you have Neovim 0.9.0+ installed
2. Back up your existing Neovim configuration if you have one:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```
3. Clone this repository:
   ```bash
   git clone https://github.com/YourUsername/nvim-config ~/.config/nvim
   ```
4. Remove the .git directory to start fresh (optional):
   ```bash
   rm -rf ~/.config/nvim/.git
   ```
5. Start Neovim:
   ```bash
   nvim
   ```
   The first launch will install all required plugins automatically.

## Structure

- `init.lua` - Main configuration entry point
- `lua/custom/` - Directory containing custom configurations
  - `plugins/` - Custom plugin configurations
  - `mappings.lua` - Custom keymaps
  - `options.lua` - Custom Neovim options

## Customization

To customize this configuration:

1. Add new plugins in `lua/custom/plugins/`
2. Modify keymaps in `lua/custom/mappings.lua`
3. Adjust Neovim options in `lua/custom/options.lua`

## Plugins

This configuration includes several carefully selected plugins to enhance the Neovim experience:

### Core Plugins
- **nvim-treesitter** - Syntax highlighting and code parsing
- **telescope.nvim** - Fuzzy finder and file navigation
- **nvim-tree.lua** - File explorer
- **mason.nvim** - Package manager for LSP servers, formatters, and linters
- **nvim-lspconfig** - LSP configuration
- **nvim-cmp** - Autocompletion plugin

### Git Integration
- **gitsigns.nvim** - Git decorations and hunks
- **lazygit.nvim** - Git UI integration

### UI Enhancements
- **nvim-web-devicons** - File icons
- **nvim-colorizer.lua** - Color highlighter
- **indent-blankline.nvim** - Indent guides
- **which-key.nvim** - Key binding helper

### Editor Enhancement
- **nvim-autopairs** - Auto bracket pairing
- **Comment.nvim** - Easy code commenting
- **nvim-surround** - Surround selections

### Language Support
- **null-ls.nvim** - Formatting and linting
- Various language servers through Mason

## Keyboard Shortcuts

### File Navigation
| Shortcut | Action | Plugin |
|----------|--------|--------|
| `<C-n>` | Toggle file explorer | nvim-tree |
| `<leader>ff` | Find files | telescope |
| `<leader>fg` | Live grep | telescope |
| `<leader>fb` | Find buffers | telescope |
| `<leader>fh` | Find help tags | telescope |
| `<C-p>` | Find git files | telescope |

### Code Navigation
| Shortcut | Action | Plugin |
|----------|--------|--------|
| `gd` | Go to definition | LSP |
| `gr` | Find references | LSP |
| `K` | Show hover documentation | LSP |
| `<leader>ca` | Code actions | LSP |
| `[d` | Previous diagnostic | LSP |
| `]d` | Next diagnostic | LSP |

### Git Operations
| Shortcut | Action | Plugin |
|----------|--------|--------|
| `<leader>gg` | Open LazyGit | lazygit |
| `]c` | Next hunk | gitsigns |
| `[c` | Previous hunk | gitsigns |
| `<leader>rh` | Reset hunk | gitsigns |
| `<leader>ph` | Preview hunk | gitsigns |
| `<leader>gb` | Blame line | gitsigns |

### Editor Commands
| Shortcut | Action | Plugin |
|----------|--------|--------|
| `gcc` | Comment line | Comment.nvim |
| `gc` | Comment selection (visual mode) | Comment.nvim |
| `ys{motion}{char}` | Surround with character | nvim-surround |
| `ds{char}` | Delete surrounding | nvim-surround |
| `cs{target}{replacement}` | Change surrounding | nvim-surround |

### Window Management
| Shortcut | Action | Plugin |
|----------|--------|--------|
| `<C-h>` | Move to left window | nvim core |
| `<C-l>` | Move to right window | nvim core |
| `<C-j>` | Move to bottom window | nvim core |
| `<C-k>` | Move to top window | nvim core |
| `<leader>sv` | Split window vertically | nvim core |
| `<leader>sh` | Split window horizontally | nvim core |

### LSP Functions
| Shortcut | Action | Plugin |
|----------|--------|--------|
| `<leader>fm` | Format document | null-ls |
| `<leader>rn` | Rename symbol | LSP |
| `<C-space>` | Trigger completion | nvim-cmp |
| `<C-e>` | Close completion window | nvim-cmp |
| `<CR>` | Confirm completion | nvim-cmp |
| `<Tab>` | Next completion item | nvim-cmp |

Note: `<leader>` is typically set to the space key in NvChad.

## Credits

1. [LazyVim starter](https://github.com/LazyVim/starter) - NvChad's starter was inspired by LazyVim's structure
2. [NvChad](https://github.com/NvChad/NvChad) - The base configuration this setup is built upon

## License

MIT
