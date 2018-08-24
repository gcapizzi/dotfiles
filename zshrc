# Tab-complete .. !
zstyle ':completion:*' special-dirs true

# Aliases
alias ls='ls -FGhp'
alias pro='tmux new-session -A -s "${PWD##*/}"'

# Default editor
export EDITOR='vim'
