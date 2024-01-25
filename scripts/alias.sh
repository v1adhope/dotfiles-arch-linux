#!/bin/bash

alias ls='exa -Fl --group-directories-first --sort=name -g --color=auto'
alias cat='bat'
alias grep='rg'
alias diff='diff -us'
alias v='nvim'
alias n='nnn'

# Removing unnecessary dependencies
alias pman='sudo pacman -Rns $(pacman -Qdtq)'

# Common commands
alias comcom='~/.local/scripts/common-commands.sh'
