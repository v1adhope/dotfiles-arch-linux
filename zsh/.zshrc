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

### If running from tty1 start sway
[ "$(tty)" = "/dev/tty1" ] && source $HOME/.config/scripts/sway/launchsway.sh

### Exports
#
# Default text editor
export EDITOR=/usr/bin/vim
# Hardware video acceleration
source "$HOME/.config/scripts/hardware-video-acceleration.sh"
# Alias
source "$HOME/.config/scripts/alias.sh"
# Customize nnn
source "$HOME/.config/nnn/cusomize-nnn.sh"

### Load promptinit
#
#autoload -Uz promptinit && promptinit
#
# Rat Theme
#prompt_mytheme_setup() {
#  PS1="%B[%F{66}%n%f@%m: %F{white}%~%f ]%# %b"
#}
#prompt_themes+=( mytheme )
#prompt mytheme

### Theme&plagins
source "$HOME/.config/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme"
source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"

### Zsh history bind
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
