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

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
#
# If running from tty1 start sway
[ "$(tty)" = "/dev/tty1" ] && source $HOME/.config/scripts/sway/launchsway.sh
#
### Exports
#
# Default text editor
export EDITOR=/usr/bin/vim
# Hardware video acceleration
source "$HOME/.config/scripts/hardware-video-acceleration.sh"
# Alias
source "$HOME/.config/scripts/alias.sh"
#
# Load promptinit
autoload -Uz promptinit && promptinit
#
# Rat Theme
prompt_mytheme_setup() {
  PS1="%B[%F{66}%n%f@%m: %F{white}%~%f ]%# %b"
}
prompt_themes+=( mytheme )
prompt mytheme
#
# Theme&plagins
source /home/rat/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/rat/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
#
# Zsh history bind
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
