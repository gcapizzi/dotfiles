# Tab-complete .. !
zstyle ':completion:*' special-dirs true

# Aliases
alias ls='ls -FGhp'
alias ll='ls -l'
alias p='tmux new-session -A -s "${PWD##*/}"'

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=10000

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_VERIFY
setopt SHARE_HISTORY

# PATH
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH"

export EDITOR='nvim'

# Emacs mode
bindkey -e

# fn + backspace = delete
# *must* come after `bindkey -e`!
bindkey "\e[3~" delete-char

# Edit commands in the $EDITOR
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# History substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# fzf
source <(fzf --zsh)

# direnv
eval "$(direnv hook zsh)"

# starship
eval "$(starship init zsh)"

# completions
fpath=(~/.zsh/zsh-completions/src $fpath)
autoload -Uz compinit
compinit

# plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
