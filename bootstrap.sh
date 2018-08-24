#!/usr/bin/env sh

set -e

endpath="$HOME/.dotfiles"

if [ -e $endpath/.git ] ; then
    echo "> update repo"
    cd $endpath && git pull
else
    echo "> clone repo"
    git clone http://github.com/gcapizzi/dotfiles.git $endpath
fi

if command -v brew >/dev/null ; then
    echo "> brew upgrade"
    brew upgrade
else
    echo "> install Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "> brew bundle"
cd $endpath && brew bundle

echo "> set up symlinks"
ln -sf $endpath/zshrc $HOME/.zshrc
ln -sf $endpath/gitconfig $HOME/.gitconfig
ln -sf $endpath/gitignore $HOME/.gitignore
ln -sf $endpath/tmux.conf $HOME/.tmux.conf

echo "> zplug install/update"
/bin/zsh -c "source ~/.zshrc && ((zplug check && zplug install) || zplug update)"
