# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="theunraveler"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in
# ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew gem git osx rails3)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# Tab-complete .. !
zstyle ':completion:*' special-dirs true

# Better history search with pgup/pgdown
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward

# Disable argument correction
setopt nocorrectall

# Homebrew
PATH=/usr/local/bin:$PATH

# NPM
PATH=/usr/local/share/npm/bin:$PATH

# Better Up and Down keys behavior
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Colored output
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Aliases
alias ls='ls -FGhp'
alias myip='echo `curl -s ipecho.net/plain`'

# Play better with Tmux
DISABLE_AUTO_TITLE=true

# Chruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# Default editor
export EDITOR='vim'

