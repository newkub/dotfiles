# ==============================================================================
# >> SHELL INITIALIZATION
# ==============================================================================

# --- mise shims ---
$env.PATH = ($env.PATH | split row (char esep) | prepend "C:/Users/Veerapong/AppData/Local/mise/shims")

# --- Starship Prompt ---
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# --- Zoxide ---
source ~/.zoxide.nu

# --- Shell integration ---
$env.config.shell_integration.osc133 = false
$env.config.show_banner = false

# --- Keybindings ---
$env.config.keybindings = [
    {
        name: accept_history_suggestion
        modifier: shift
        keycode: right
        mode: [emacs vi_normal vi_insert]
        event: { send: historyhintcomplete }
    }
]

# ==============================================================================
# >> ENVIRONMENT VARIABLES
# ==============================================================================

$env.CLAUDE_CODE_GIT_BASH_PATH = "C:\\Users\\Veerapong\\scoop\\shims\\git.exe"

# --- Proto ---
$env.PROTO_HOME = ($nu.home-dir | path join ".proto")
$env.PATH = ($env.PATH | split row (char esep)
    | prepend ($env.PROTO_HOME | path join "shims")
    | prepend ($env.PROTO_HOME | path join "bin"))

# ==============================================================================
# >> ALIASES
# ==============================================================================

alias c = clear
alias y = yazi
alias n = nvim
alias v = bat
alias ot = hx
alias new = new-item
alias nu = C:\Users\Veerapong\scoop\apps\nu\current\nu.exe

# ==============================================================================
# >> NAVIGATION
# ==============================================================================

alias home = cd ~
alias downloads = cd ~/Downloads
alias desktop = cd ~/Desktop
alias docs = cd ~/Documents
alias d = cd D:\
alias cnotes = cd C:\Users\Veerapong\Documents\notes
alias images = cd ~/Pictures
alias videos = cd ~/Videos
alias projects = cd ~/Projects
alias scripts = cd ~/Documents/PowerShell
alias appdata = cd ~/AppData
alias local = cd ~/AppData/Local
alias config = cd ~/.config
alias dotfiles = cd ~/.local/share/chezmoi
alias temp = cd $env.TEMP
alias windsurf-path = cd ~/.codeium/windsurf
alias newkub = cd D:\newkub

def dd [] { explorer C:\Users\Veerapong\Downloads }
def ep [] { explorer C:\Users\Veerapong }
def b [] { broot }

# cc: search directories on D:\ with fd + tv
def cc [
    query?: string
] {
    let root = "D:\\"
    let dirs = if $query != null { fd -t d $query $root } else { fd -t d . $root }
    let selected = ($dirs | tv)
    if ($selected | is-not-empty) { cd $selected }
}

# cdi: interactive directory picker (current dir)
def --env cdi [
    query?: string
] {
    if $query != null {
        cd $query
    } else {
        let dirs = (fd -t d)
        let selected = ($dirs | tv)
        if ($selected | is-not-empty) { cd $selected }
    }
}

# cdd: search directories on D:\ with optional query
def --env cdd [
    query?: string
] {
    let root = "D:\\"
    if $query != null {
        cd $"($root)($query)"
    } else {
        let dirs = (fd -t d . $root)
        let selected = ($dirs | tv)
        if ($selected | is-not-empty) { cd $selected }
    }
}

def cdqoderworkflows [] { cd C:\Users\Veerapong\.codeium\windsurf\global_workflows; ls }

# ==============================================================================
# >> EDITOR FUNCTIONS
# ==============================================================================

def o [...files] { if ($files | is-empty) { code . } else { code ...$files } }
def w [...args] { if ($args | is-empty) { windsurf . } else { windsurf --reuse-window ...$args } }
def openwindsurf [...args] { if ($args | is-empty) { windsurf . } else { windsurf ...$args } }

def f [
    query?: string
] {
    let files = if $query != null { fd -t f $query } else { fd -t f }
    let selected = ($files | tv)
    if ($selected | is-not-empty) { windsurf $selected }
}

def ff [
    query?: string
] {
    let dirs = if $query != null { fd -t d $query } else { fd -t d }
    let selected = ($dirs | tv)
    if ($selected | is-not-empty) { windsurf $selected }
}

def owindsurfrules [] { windsurf C:\Users\Veerapong\.codeium\windsurf\memories\global_rules.md }
def opowershellprofile [] { windsurf C:\Users\Veerapong\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 }
def otd [] { zed d:\TODO.md }

# ==============================================================================
# >> SCRIPT RUNNERS
# ==============================================================================

# --- Directory listing with eza ---
def dir [] { eza --long --git --git-repos --octal-permissions --total-size --time-style=relative --group-directories-first --color-scale=age,size --header --hyperlink --all }

# --- mise task ---
def t [...args] { mise task run ...$args }

# --- Bun script runners ---
def rd [] { ni; bun run dev }
def rw [] { ni; bun run watch }
def rb [] { ni; bun run build }
def rl [] { ni; bun run lint }
def rt [] { ni; bun run test }
def rr [] { ni; bun run review }
def rf [] { ni; bun run format }
def rc [] { ni; bun run typecheck }

# --- Moon script runners ---
def md [] { ni; moon run :dev }
def mw [] { ni; moon run :watch }
def mb [] { ni; moon run :build }
def ml [] { ni; moon run :lint }
def mt [] { ni; moon run :test }
def mr [] { ni; moon run :review }
def mf [] { ni; moon run :format }
def mc [] { ni; moon run :typecheck }

# ==============================================================================
# >> FILE OPERATIONS
# ==============================================================================

def rmi [
    query?: string
] {
    let dirs = if $query != null { fd -t d --hidden $query } else { fd -t d --hidden }
    let selected = ($dirs | tv)
    if ($selected | is-not-empty) {
        print "Select delete type:"
        print "1. Normal delete"
        print "2. Recursive delete"
        let choice = (input "Enter choice (1 or 2): ")
        if $choice == "1" {
            let confirm = (input $"Delete normally '($selected)'? (y/n): ")
            if $confirm == "y" { rm $selected; print $"Deleted: ($selected)" }
        } else if $choice == "2" {
            let confirm = (input $"Delete recursively '($selected)'? (y/n): ")
            if $confirm == "y" { rm -r -f $selected; print $"Deleted recursively: ($selected)" }
        }
    }
}

def notes [
    action?: string
] {
    let notesDir = "C:\\Users\\Veerapong\\Documents\\notes"
    if not ($notesDir | path exists) { mkdir $notesDir }
    if $action == "new" {
        let fileName = (input "Enter note name (no extension): ")
        if ($fileName | is-empty) { print "Cancelled"; return }
        let fullPath = ($notesDir | path join $"($fileName).md")
        if ($fullPath | path exists) { print $"File exists: ($fullPath)"; return }
        touch $fullPath
        print $"Note created: ($fullPath)"
        windsurf $fullPath
    } else {
        let query = if $action != null { $action } else { "." }
        let selected = (fd -t f $query $notesDir | tv)
        if ($selected | is-not-empty) { windsurf $selected }
    }
}

# ==============================================================================
# >> UTILITY FUNCTIONS
# ==============================================================================

def e [] { explorer . }
def cpath [] { $env.PWD | clip }
def cpc [
    file: string
] {
    if ($file | path exists) {
        open $file --raw | clip
        print $"Content copied from: ($file)"
    } else {
        print $"File not found: ($file)"
    }
}

# ==============================================================================
# >> GITHUB FUNCTIONS
# ==============================================================================

def new-repo [] {
    let name = (input "Enter repo name: ")
    gh repo create $name --public --clone
}

def repo [] {
    let inRepo = (try { git rev-parse --is-inside-work-tree } catch { null })
    if $inRepo == "true" {
        gh repo view --web
    } else {
        start "https://github.com/newkub?tab=repositories"
    }
}

# ==============================================================================
# >> SEARCH FUNCTIONS
# ==============================================================================

def g [
    ...args
] {
    if ($args | is-empty) {
        start "https://www.google.com"
        return
    }
    let engines = {
        google: "https://www.google.com/search?q={0}"
        npm: "https://www.npmjs.com/search?q={0}"
        github: "https://github.com/search?q={0}"
        youtube: "https://www.youtube.com/results?search_query={0}"
        chatgpt: "https://chat.openai.com/?q={0}"
        crates: "https://crates.io/search?q={0}"
    }
    let first = ($args.0 | str downcase)
    if $first in $engines {
        let engine = ($engines | get $first)
        let query = (($args | skip 1) | str join " " | url encode)
        start ($engine | str replace "{0}" $query)
    } else {
        let query = ($args | str join " " | url encode)
        start $"https://www.google.com/search?q=($query)"
    }
}

def op [
    port: int
] {
    start $"http://localhost:($port)"
}

# ==============================================================================
# >> CLIPBOARD FUNCTIONS
# ==============================================================================

def cpo [] {
    let last = (history | last)
    if ($last | is-empty) {
        print "No history found"
        return
    }
    let output = (do $last | table --width 4096)
    $output | clip
    print "Last command output copied."
}

# ==============================================================================
# >> AI
# ==============================================================================

def ai [...args] { gh copilot ...$args }
