# Oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="theunraveler"
plugins=(brew gem git osx rails bundler zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Tab-complete .. !
zstyle ':completion:*' special-dirs true

# Better history search with pgup/pgdown
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward

# Disable argument correction
setopt nocorrectall

# Homebrew
PATH=/usr/local/bin:/usr/local/sbin:$PATH

# Better Up and Down keys behavior
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Colored output
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Aliases
alias ls='ls -FGhp'
alias myip='echo `curl -s ipecho.net/plain`'
alias pro='tmux new-session -A -s "${PWD##*/}"'

# Play better with Tmux
export DISABLE_AUTO_TITLE=true

# Chruby
[ -e /usr/local/opt/chruby/share/chruby/chruby.sh ] && source /usr/local/opt/chruby/share/chruby/chruby.sh
[ -e /usr/local/opt/chruby/share/chruby/auto.sh ] && source /usr/local/opt/chruby/share/chruby/auto.sh

# Default editor
export EDITOR='vim'

# z
[ -e `brew --prefix`/etc/profile.d/z.sh ] && . `brew --prefix`/etc/profile.d/z.sh

# gh
command -v gh >/dev/null 2>&1 && alias git=gh
