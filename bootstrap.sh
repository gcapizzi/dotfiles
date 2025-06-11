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
	brew install direnv fd fzf git git-delta neovim ripgrep ruby starship tmux
fi

if command -v -- "port" >/dev/null 2>&1; then
	sudo port install direnv fd fzf git git-delta neovim ripgrep starship tmux trash
fi

dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

echo "> set up symlinks"
ln -sf "$dir/zshrc" "$HOME/.zshrc"
ln -sf "$dir/gitconfig" "$HOME/.gitconfig"
ln -sf "$dir/gitignore" "$HOME/.gitignore"
ln -sf "$dir/tmux.conf" "$HOME/.tmux.conf"
ln -sf "$dir/alacritty.toml" "$HOME/.alacritty.toml"
ln -sf "$dir/wezterm.lua" "$HOME/.wezterm.lua"

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
