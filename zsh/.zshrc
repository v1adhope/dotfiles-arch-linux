# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/rat/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

### If not running interactively, don't do anything
[[ $- != *i* ]] && return

### If running from tty1 start sway and its deps
[ "$(tty)" = "/dev/tty1" ] && for f in $HOME/.config/sway/load/*.sh; do source $f; done

### Exports
#
# Ls and exa color overwrite
export LS_COLORS="di=01;38;5;12:ln=01;38;5;13:or=01;38;5;167:ex=38;5;115:*.*=00"
export EXA_COLORS="ur=01;38;5;187:uw=01;38;5;167:ux=01;38;5;115:ue=01;38;5;115:gr=01;38;5;187:gw=01;38;5;167:gx=01;38;5;115:tr=01;38;5;187:tw=01;38;5;167:tx=01;38;5;115:uu=01;38;5;13:gu=01;38;5;13:un=01;38;5;12:gn=01;38;5;12:sn=38;5;115:sb=38;5;115:da=38;5;187:lp=01;38;5;13:b0=01;38;5;167"
# Set default text editor
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
# My executable scripts
export PATH=$HOME/.config/scripts/bin:$PATH
# Go
export GOPATH=$HOME/.local/share/go
export PATH=$HOME/.local/share/go/bin:$PATH
# Lua
export PATH=$HOME/.config/lsp/lua-language-server/bin:$PATH
# Hardware video acceleration
source "$HOME/.config/scripts/hardware-video-acceleration.sh"
# Alias
source "$HOME/.config/scripts/alias.sh"
# Customize nnn
source "$HOME/.config/nnn/customize.sh"

### Theme&plagins
source "$HOME/.config/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme"
source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"

### Zsh history bind
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
