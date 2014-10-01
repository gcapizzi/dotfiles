#!/usr/bin/env sh

endpath="$HOME/.dotfiles"
ohmyzshpath="$HOME/.oh-my-zsh"
zshshpath="$ohmyzshpath/custom/plugins/zsh-syntax-highlighting"

echo "\n### Bootstrap started ###"

if [ -e $ohmyzshpath/.git ]; then
    echo "\n> update oh-my-zsh\n"
    cd $ohmyzshpath && git pull
else
    echo "\n> install oh-my-zsh\n"
    git clone git://github.com/robbyrussell/oh-my-zsh.git $ohmyzshpath
    chsh -s `which zsh`
fi

if [ -e $zshshpath/.git ]; then
    echo "\n> update zsh-syntax-highlighting\n"
    cd $zshshpath && git pull
else
    echo "\n> install zsh-syntax-highlighting\n"
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $zshshpath
fi

if [ -e $endpath/.git ]; then
    echo "\n> update repo\n"
    cd $endpath && git pull
else
    echo "\n> clone repo\n"
    git clone http://github.com/gcapizzi/dotfiles.git $endpath
fi

echo "> set up symlinks\n"
ln -sf $endpath/vimrc.local $HOME/.vimrc.local
ln -sf $endpath/vimrc.plugins.local $HOME/.vimrc.plugins.local
ln -sf $endpath/zshrc $HOME/.zshrc
ln -sf $endpath/zshenv $HOME/.zshenv
ln -sf $endpath/gitconfig $HOME/.gitconfig
ln -sf $endpath/cvsignore $HOME/.cvsignore
ln -sf $endpath/gemrc $HOME/.gemrc
ln -sf $endpath/tmux.conf $HOME/.tmux.conf

echo "\n> update/install Vim plugins using Vundle\n"
vim </dev/tty +PluginInstall +PluginClean +qall
