#!/usr/bin/env sh

set -e

endpath="$HOME/.dotfiles"

echo "\n### Bootstrap started ###"

if [ -e $endpath/.git ] ; then
    echo "\n> update repo\n"
    cd $endpath && git pull
else
    echo "\n> clone repo\n"
    git clone http://github.com/gcapizzi/dotfiles.git $endpath
fi

if command -v brew ; then
    echo "\n> brew upgrade\n"
    brew upgrade
else
    echo "\n> install Homebrew\n"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "> brew bundle\n"
cd $endpath && brew bundle

echo "> set up symlinks\n"
ln -sf $endpath/zshrc $HOME/.zshrc
ln -sf $endpath/gitconfig $HOME/.gitconfig
ln -sf $endpath/gitignore $HOME/.gitignore
ln -sf $endpath/tmux.conf $HOME/.tmux.conf

if zplug check ; then
    echo "\n> zplug update\n"
    zplug update
else
    echo "\n> zplug install\n"
    zplug install
fi

