#!/bin/bash

alias ls='ls -lhN --color=auto --group-directories-first'

# Removing unnecessary dependencies
alias pman='sudo pacman -R $(pacman -Qdtq)'
# Common commands 
alias comcom='~/.config/scripts/common-commands.sh'
# Wireguard connect support tool
alias wgc='~/.config/scripts/wireguard-connection.sh'
# PostgreSQL support tool
alias ps='~/.config/scripts/postgres/use-postgres.sh'

