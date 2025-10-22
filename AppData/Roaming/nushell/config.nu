# config.nu
#
# Installed by:
# version = "0.101.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.



# starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

$env.config.shell_integration.osc133 = false



# แสดง welcome message
$env.config.show_banner = false

# กำหนด keybindings
$env.config.keybindings = [
    {
        name: accept_history_suggestion
        modifier: shift
        keycode: right
        mode: [emacs vi_normal vi_insert]
        event: { send: historyhintcomplete }
    }
]

# Initialize zoxide
source ~/.zoxide.nu

# Update alias for broot with preview
alias b = broot --show-git-info --git-ignored 

# เพิ่ม aliases
alias b = broot
alias y = yazi
alias w = windsurf
alias dir = eza --grid


# เพิ่ม aliases สำหรับ directory พร้อมคำสั่ง cd
alias home = cd C:\\Users\\Veerapong
alias appdata = cd C:\\Users\\Veerapong\\AppData
alias temp = cd $env.TEMP
alias local = cd C:\\Users\\Veerapong\\AppData\\Local
alias d = cd D:\
alias newkub = cd D:\newkub
alias downloads = cd C:\\Users\\Veerapong\\Downloads
alias .config = cd C:\\Users\\Veerapong\\.config
alias dotfiles = cd C:\\Users\\Veerapong\\.local\\share\\chezmoi
alias docs = cd C:\\Users\\Veerapong\\Documents
alias desktop = cd C:\\Users\\Veerapong\\Desktop
alias config = cd C:\\Users\\Veerapong\\.config
alias images = cd C:\\Users\\Veerapong\\Pictures
alias videos = cd C:\\Users\\Veerapong\\Videos
alias projects = cd C:\\Users\\Veerapong\\Projects
alias scripts = cd C:\\Users\\Veerapong\\Documents\\PowerShell

