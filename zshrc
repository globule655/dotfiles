export CLICOLOR=1
export EDITOR="nvim"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export PATH=$PATH:~/.local/bin
export VAULT_PATH="$HOME/Documents/git_perso/doc.git/main"
export DOTFILES_PATH="$HOME/Documents/git_perso/dotfiles"
# Allow zsh-autosuggestions to persist
setopt APPEND_HISTORY
setopt SHARE_HISTORY
HISTFILE=$HOME/.zsh_history
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source <(fzf --zsh)

# zsh completion to correct approximations & give select menu for multiple choices
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _extensions _complete _approximate

eval "$(starship init zsh)"

alias ls="eza"
alias cat="bat --theme='base16-256'"
alias ov="cd $VAULT_PATH; nvim ."
alias dot="cd $DOTFILES_PATH; nvim ."

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
eval "$(zoxide init --cmd cd zsh)"
