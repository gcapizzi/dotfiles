#!/bin/bash

set -e

git_ensure() {
	if [ -d "$2" ]; then
		git -C "$2" pull
	else
		git clone "$1" "$2"
	fi
}

brew install direnv fd fzf git git-delta herdr neovim ripgrep starship tmux umputun/apps/revdiff

dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

echo "> set up symlinks"
ln -sf "$dir/zshrc" "$HOME/.zshrc"
ln -sf "$dir/gitconfig" "$HOME/.gitconfig"
ln -sf "$dir/gitignore" "$HOME/.gitignore"
ln -sf "$dir/tmux.conf" "$HOME/.tmux.conf"
ln -sf "$dir/wezterm.lua" "$HOME/.wezterm.lua"
mkdir -p "$HOME/.config/ghostty" && ln -sf "$dir/ghostty" "$HOME/.config/ghostty/config"
mkdir -p "$HOME/.config/herdr" && ln -sf "$dir/herdr.toml" "$HOME/.config/herdr/config.toml"
mkdir -p "$HOME/.config/revdiff" && ln -sf "$dir/revdiff" "$HOME/.config/revdiff/config"

echo "> zsh plugins and completions"
mkdir -p "$HOME/.zsh"

git_ensure https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git_ensure https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search
git_ensure https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
git_ensure https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions

echo "> tmux plugins"
git_ensure https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin

echo "> install nvim config"
git_ensure git@github.com:gcapizzi/nvim-lua.git "$HOME/.config/nvim"
