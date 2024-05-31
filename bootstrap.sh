#!/bin/bash

set -e

if [[ "$CODESPACES" == "true" ]]; then
	NONINTERNACTIVE=1 bash <(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if command -v -- "brew" >/dev/null 2>&1; then
	brew install direnv fd fzf git git-delta neovim ripgrep starship tmux
fi

if command -v -- "port" >/dev/null 2>&1; then
	sudo port install direnv fd fzf git git-delta neovim ripgrep starship tmux
fi

dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

echo "> set up symlinks"
ln -sf "$dir/zshrc" "$HOME/.zshrc"
ln -sf "$dir/gitconfig" "$HOME/.gitconfig"
ln -sf "$dir/gitignore" "$HOME/.gitignore"
ln -sf "$dir/tmux.conf" "$HOME/.tmux.conf"
ln -sf "$dir/alacritty.toml" "$HOME/.alacritty.toml"

if [[ "$CODESPACES" == "true" ]]; then
	printf '%s\n%s\n' "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" "$(cat ~/.zshrc)" >~/.zshrc
	sudo chsh "$(id -un)" --shell "/usr/bin/zsh"
fi

echo "> zsh plugins and completions"
mkdir -p "$HOME/.zsh"

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions

echo "> install nvim config"
if [[ ! -d "$HOME/.config/nvim" ]]; then
	git clone https://github.com/gcapizzi/nvim-lua.git ~/.config/nvim
fi
