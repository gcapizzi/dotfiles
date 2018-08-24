# Tab-complete .. !
zstyle ':completion:*' special-dirs true

# Aliases
alias ls='ls -FGhp'
alias pro='tmux new-session -A -s "${PWD##*/}"'

# Default editor
export EDITOR='vim'

# fasd
eval "$(fasd --init auto)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "dracula/zsh", as:theme, use:dracula.zsh-theme

zplug load
