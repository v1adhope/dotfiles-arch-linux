#!/bin/bash

alias ls='exa -F -l --group-directories-first --sort=name -g --color=auto'
alias cat='bat'
alias grep='rg'
alias diff='diff -us'
alias v='nvim'
alias n='nnn'
alias py="python3"
alias task="go-task"

# Removing unnecessary dependencies
alias pman='sudo pacman -Rns $(pacman -Qdtq)'

# Common commands
alias comcom='~/.local/scripts/common-commands.sh'
alias ad-ch='adguardvpn-cli connect --location CH'
alias ad-nl='adguardvpn-cli connect --location NL'
