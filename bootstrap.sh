#!/bin/bash

set -e

git_ensure() {
	if [ -d "$2" ]; then
		git -C "$2" pull
	else
		git clone "$1" "$2"
	fi
}

if [[ "$CODESPACES" == "true" ]]; then
	NONINTERNACTIVE=1 bash <(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	brew install trash-cli
fi

if command -v -- "brew" >/dev/null 2>&1; then
	brew install direnv fd fzf git git-delta neovim ripgrep ruby starship tmux zellij
fi

if command -v -- "port" >/dev/null 2>&1; then
	sudo port install direnv fd fzf git git-delta neovim ripgrep starship tmux trash zellij
fi

if command -v -- "pacman" >/dev/null 2>&1; then
	sudo pacman -S --needed direnv fd fzf git git-delta neovim ripgrep starship tmux trash-cli zellij
fi

dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

echo "> set up symlinks"
ln -sf "$dir/zshrc" "$HOME/.zshrc"
ln -sf "$dir/gitconfig" "$HOME/.gitconfig"
ln -sf "$dir/gitignore" "$HOME/.gitignore"
ln -sf "$dir/tmux.conf" "$HOME/.tmux.conf"
ln -sf "$dir/alacritty.toml" "$HOME/.alacritty.toml"
ln -sf "$dir/wezterm.lua" "$HOME/.wezterm.lua"
ln -sf "$dir/wezterm.lua" "$HOME/.wezterm.lua"
mkdir -p "$HOME/.config/zellij" && ln -sf "$dir/zellij.kdl" "$HOME/.config/zellij/config.kdl"

if [[ "$CODESPACES" == "true" ]]; then
	printf '%s\n%s\n' "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" "$(cat ~/.zshrc)" >~/.zshrc
	sudo chsh "$(id -un)" --shell "/usr/bin/zsh"
fi

echo "> zsh plugins and completions"
mkdir -p "$HOME/.zsh"

git_ensure https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git_ensure https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search
git_ensure https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
git_ensure https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions

echo "> tmux plugins"
git_ensure https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin

echo "> install nvim config"
git_ensure https://github.com/gcapizzi/nvim-lua.git "$HOME/.config/nvim"
