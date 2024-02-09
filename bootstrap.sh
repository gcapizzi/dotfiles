#!/usr/bin/env sh

set -e

endpath="$HOME/.dotfiles"

if [ -e "$endpath/.git" ]; then
	echo "> update repo"
	cd "$endpath" && git pull
else
	echo "> clone repo"
	git clone http://github.com/gcapizzi/dotfiles.git "$endpath"
fi

echo "> set up symlinks"
ln -sf "$endpath/zshrc" "$HOME/.zshrc"
ln -sf "$endpath/gitconfig" "$HOME/.gitconfig"
ln -sf "$endpath/gitignore" "$HOME/.gitignore"
ln -sf "$endpath/tmux.conf" "$HOME/.tmux.conf"
rm -f "$HOME/.alacritty.yml"
ln -sf "$endpath/alacritty.toml" "$HOME/.alacritty.toml"

echo "> zplug install/update"
/bin/zsh -c "source ~/.zshrc && ((zplug check && zplug install) || zplug update)"
