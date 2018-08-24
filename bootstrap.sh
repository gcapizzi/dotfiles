#!/usr/bin/env sh

endpath="$HOME/.dotfiles"

echo "\n### Bootstrap started ###"

if [ -e $endpath/.git ]; then
    echo "\n> update repo\n"
    cd $endpath && git pull
else
    echo "\n> clone repo\n"
    git clone http://github.com/gcapizzi/dotfiles.git $endpath
fi

echo "> set up symlinks\n"
ln -sf $endpath/zshrc $HOME/.zshrc
ln -sf $endpath/gitconfig $HOME/.gitconfig
ln -sf $endpath/gitignore $HOME/.gitignore
ln -sf $endpath/tmux.conf $HOME/.tmux.conf

if zplug check; then
    echo "\n> zplug update\n"
    zplug update
else
    echo "\n> zplug install\n"
    zplug install
fi

