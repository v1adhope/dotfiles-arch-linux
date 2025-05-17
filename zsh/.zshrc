# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zstyle :compinstall filename "$HOME/.zshrc"

# === Load plugins and completion ===
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Before prompt
zinit light-mode depth=1 for \
    romkatv/powerlevel10k \
  atload"export ZVM_CURSOR_STYLE_ENABLED=false" \
    jeffreytse/zsh-vi-mode \

# After prompt
function zsh_history_bindkeys {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
}

zinit wait lucid light-mode depth=1 for \
  atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  atload"zsh_history_bindkeys" \
    zsh-users/zsh-history-substring-search

# === Settings ===
bindkey -v

# Increasing the limit of open file descriptors for the current shell session
ulimit -n 8096

# Zsh history
setopt hist_ignore_all_dups
setopt hist_ignore_space
HISTFILE=~/.zsh_histfile
HISTSIZE=100000
SAVEHIST=100000

# Remove $PATH duplicates
typeset -U PATH

# === Exports and sources ===
config_path=$HOME/.config
local_path=$HOME/.local

# Hardware video acceleration
export VDPAU_DRIVER=radeonsi

# Default text editor
export EDITOR=$(which nvim)
export VISUAL=$(which nvim)

# Aliases
[ -s $local_path/scripts/aliases.sh ] && source $local_path/scripts/aliases.sh

# Private
[ -s $HOME/Dropbox/arch/.private ] && source $HOME/Dropbox/arch/.private

# Ls and exa color overwrite
export LS_COLORS="di=01;38;5;12:ln=01;38;5;13:or=01;38;5;167:ex=38;5;115:*.*=00"
export EXA_COLORS="ur=01;38;5;187:uw=01;38;5;167:ux=01;38;5;115:ue=01;38;5;115:gr=01;38;5;187:gw=01;38;5;167:gx=01;38;5;115:tr=01;38;5;187:tw=01;38;5;167:tx=01;38;5;115:uu=01;38;5;13:gu=01;38;5;13:un=01;38;5;12:gn=01;38;5;12:sn=38;5;115:sb=38;5;115:da=38;5;187:lp=01;38;5;13:b0=01;38;5;167"

# Executable scripts
[ -s $HOME/.local/scripts/bin ] && export PATH=$HOME/.local/scripts/bin:$PATH

# Customize nnn
[ -s $config_path/nnn/customize.sh ] && source $config_path/nnn/customize.sh

# Go
export GOPATH=$local_path/share/go
export PATH=$local_path/share/go/bin:$PATH

export GONOSUMDB=gitea.gospodaprogrammisty.ru
export GOPROXY=https://proxy.golang.org,direct

# Rust

export RUSTUP_HOME=$local_path/share/rust
export CARGO_HOME=$local_path/share/cargo
export PATH=$CARGO_HOME/bin:$PATH
export RUST_BACKTRACE=1

# .NET
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Node
[ -s /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh

# === Loads ===
# Start hypr and its deps after log in
[ "$(tty)" = "/dev/tty1" ] && for f in $config_path/hypr/load/*.sh; do source $f; done

# Completion adguardvpn-cli: TODO: fix
[ -s "/opt/adguardvpn_cli/bash-completion.sh" ] && source /opt/adguardvpn_cli/bash-completion.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -Uz compinit
compinit
