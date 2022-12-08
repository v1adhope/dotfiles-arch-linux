#!/bin/bash

alias ls='ls -lhN --color=auto --group-directories-first'
alias v='nvim'
alias n='nnn'
alias diff='diff -us'

# Removing unnecessary dependencies
alias pman='sudo pacman -R $(pacman -Qdtq)'
# Common commands 
alias comcom='~/.config/scripts/common-commands.sh'
# Wireguard connect support tool
alias wgc='~/.config/scripts/VPN/wireguard-connection.sh'
# PostgreSQL support tool
alias ps='~/.config/scripts/postgres/use-postgres.sh'

