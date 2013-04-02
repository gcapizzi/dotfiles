#!/usr/bin/env sh

endpath="$HOME/.dotfiles"
ohmyzshpath="$HOME/.oh-my-zsh"

echo "\n### Bootstrap started ###"

if [ -e $ohmyzshpath/.git ]; then
    echo "\n> update oh-my-zsh\n"
    cd $ohmyzshpath && git pull
else
    echo "\n> install oh-my-zsh\n"
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    chsh -s `which zsh`
fi

if [ -e $endpath/.git ]; then
    echo "\n> update repo\n"
    cd $endpath && git pull
else
    echo "\n> clone repo\n"
    git clone http://github.com/gcapizzi/dotfiles.git $endpath
fi

echo "> set up symlinks\n"
ln -sf $endpath/vimrc $HOME/.vimrc
ln -sf $endpath/zshrc $HOME/.zshrc
ln -sf $endpath/gitconfig $HOME/.gitconfig
ln -sf $endpath/cvsignore $HOME/.cvsignore
ln -sf $endpath/gemrc $HOME/.gemrc

if [ ! -e $HOME/.vim/bundle/vundle ]; then
    echo "> install Vundle\n"
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi

echo "\n> update/install plugins using Vundle\n"
vim </dev/tty +BundleInstall! +BundleClean +qall
