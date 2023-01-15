#!/bin/bash

alias ls='exa -Fl --group-directories-first --sort=name -g --color=auto'
alias cat='bat'
alias v='nvim'
alias n='nnn'
alias diff='diff -us'

# Removing unnecessary dependencies
alias pman='sudo pacman -R $(pacman -Qdtq)'
# Common commands
alias comcom='~/.config/scripts/common-commands.sh'
# Wireguard connect support tool
alias wgc='~/.config/scripts/wireguard-connection.sh'
