#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza --group-directories-first'
alias ll='eza -l --group-directories-first --git'
alias la='eza -la --group-directories-first --git'
alias lt='eza --tree --level=2'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# mise
export PATH="$HOME/.local/bin:$PATH"
eval "$(mise activate bash)"

# starship (installed via mise)
eval "$(starship init bash)"

# WSLg GUI support
export XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir
export WAYLAND_DISPLAY=wayland-0
export DISPLAY=:0

# starship shell label
export STARSHIP_SHELL=bash

# bash-completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi
