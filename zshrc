# Tab-complete .. !
zstyle ':completion:*' special-dirs true

# Aliases
alias ls='ls -FGhp'
alias ll='ls -l'
alias p='tmux new-session -A -s "${PWD##*/}"'

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

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# direnv
eval "$(direnv hook zsh)"

# starship
eval "$(starship init zsh)"

# zplug
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug load
