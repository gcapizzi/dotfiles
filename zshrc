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
export PATH="/opt/local/bin:/opt/local/sbin:$PATH" # MacPorts
export PATH="$HOME/go/bin:$PATH"

export EDITOR='nvim'

export FPATH="/opt/local/share/zsh/5.9/functions:$FPATH"

# Emacs mode
bindkey -e
# fn + backspace = delete
bindkey "\e[3~" delete-char
# home/end
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
# page up/down = word back/forward
bindkey "\e[5~" backward-word
bindkey "\e[6~" forward-word

# Edit commands in the $EDITOR
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

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
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
