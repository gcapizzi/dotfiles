#!/usr/bin/env sh

set -e

dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

echo "> set up symlinks"
ln -sf "$dir/zshrc" "$HOME/.zshrc"
ln -sf "$dir/gitconfig" "$HOME/.gitconfig"
ln -sf "$dir/gitignore" "$HOME/.gitignore"
ln -sf "$dir/tmux.conf" "$HOME/.tmux.conf"
ln -sf "$dir/alacritty.toml" "$HOME/.alacritty.toml"

echo "> zplug install/update"
git clone https://github.com/zplug/zplug.git ~/.zplug
/bin/zsh -c "source ~/.zshrc && ((zplug check && zplug install) || zplug update)"
