# My personal dotfiles

These are my personal dotfiles. To use them, just clone the repo in your
home directory:

    git clone git@github.com:gcapizzi/dotfiles.git ~/.dotfiles

and then make symlinks:

    ln -s ~/.dotfiles/vim ~/.vim
    ln -s ~/.dotfiles/vimrc ~/.vimrc
    ln -s ~/.dotfiles/zshrc ~/.zshrc
    ln -s ~/.dotfiles/gitconfig ~/.gitconfig

To get all needed Vim plugins and dependencies, you'll need to update
git submodules:

    cd ~/.dotfiles
    git submodule update --init
