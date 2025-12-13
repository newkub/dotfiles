# Dotfiles

Personal dotfiles managed with [Chezmoi](https://www.chezmoi.io/).

## 📋 Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Structure](#structure)
- [License](#license)

## Prerequisites

- [Chezmoi](https://www.chezmoi.io/install/)
- Git

## Installation

### Installing Chezmoi

| Method | Command | Notes |
|--------|---------|-------|
| **Windows (Winget)** | `winget install twpayne.chezmoi` | Requires Windows Package Manager |
| **Windows (Scoop)** | `scoop install chezmoi` | For Scoop users |
| **macOS (Homebrew)** | `brew install chezmoi` | Requires Homebrew |
| **Linux (Snap)** | `sudo snap install chezmoi --classic` | For Snap-supported Linux |
| **Linux (AUR)** | `yay -S chezmoi` | For Arch Linux (requires yay) |

### Basic Usage

1. Initialize and apply dotfiles:
   ```sh
   chezmoi init --apply https://github.com/yourusername/dotfiles.git
   ```

## Usage

| Command | Description | Example |
|---------|-------------|---------|
| `chezmoi apply` | Apply changes | `chezmoi apply` |
| `chezmoi edit [file]` | Edit a dotfile | `chezmoi edit ~/.zshrc` |
| `chezmoi add [file]` | Add a new file to dotfiles | `chezmoi add ~/.newfile` |
| `chezmoi update` | Update dotfiles from repo | `chezmoi update` |
| `chezmoi diff` | Show changes | `chezmoi diff` |
| `chezmoi cd` | Go to dotfiles directory | `cd $(chezmoi source-path)` |
| `chezmoi managed` | List all managed files | `chezmoi managed` |
| `chezmoi unmanaged` | List unmanaged files | `chezmoi unmanaged` |

### Common Examples

1. Add a new config file:
   ```sh
   chezmoi add ~/.config/nvim/init.vim
   ```

2. Apply changes with verbose output:
   ```sh
   chezmoi apply -v
   ```

## Structure

```
.chezmoi/
├── .chezmoi.toml    # Chezmoi configuration
├── dot_config/      # ~/.config/
├── dot_local/       # ~/.local/
└── README.md        # This file
```
## License

MIT

---

Managed with ❤️ using [Chezmoi](https://www.chezmoi.io/)