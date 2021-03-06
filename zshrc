# Tab-complete .. !
zstyle ':completion:*' special-dirs true

# fn + backspace = delete
bindkey "\e[3~" delete-char

# Aliases
alias ls='ls -FGhp'
alias ll='ls -l'
alias p='tmux new-session -A -s "${PWD##*/}"'

# PATH
export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"

export EDITOR='nvim'

# Emacs mode
bindkey -e

# fasd
eval "$(fasd --init auto)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# direnv
eval "$(direnv hook zsh)"

# starship
eval "$(starship init zsh)"

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "dracula/zsh", as:theme, use:dracula.zsh-theme

zplug load
