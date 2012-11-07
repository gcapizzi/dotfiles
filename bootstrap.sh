#!/usr/bin/env sh

endpath="$HOME/.dotfiles"

echo "\n### Bootstrap started ###"

echo "\n> install oh-my-zsh\n"
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
chsh -s `which zsh`

echo "\n> clone repo\n"
git clone http://github.com/gcapizzi/dotfiles.git $endpath

echo "> set up symlinks\n"
ln -s $endpath/vimrc $HOME/.vimrc
ln -s $endpath/zshrc $HOME/.zshrc
ln -s $endpath/gitconfig $HOME/.gitconfig
ln -s $endpath/cvsignore $HOME/.cvsignore

if [ ! -e $HOME/.vim/bundle/vundle ]; then
    echo "> install Vundle\n"
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi

echo "\n> update/install plugins using Vundle\n"
vim +BundleInstall! +BundleClean +qall
