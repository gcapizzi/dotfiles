#!/bin/bash

set -e

if [[ "$CODESPACES" == "true" ]]; then
	NONINTERNACTIVE=1 bash <(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if command -v -- "brew" >/dev/null 2>&1; then
	brew install direnv fzf git git-delta neovim starship tmux
fi

if command -v -- "port" >/dev/null 2>&1; then
	sudo port install direnv fzf git git-delta neovim starship tmux
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

echo "> zplug install/update"
if [[ -d "$HOME/.zplug" ]]; then
	/bin/zsh -c "source ~/.zshrc && zplug update"
else
	git clone https://github.com/zplug/zplug.git ~/.zplug
	/bin/zsh -c "source ~/.zshrc && zplug install"
fi

echo "> install nvim config"
if [[ ! -d "$HOME/.config/nvim" ]]; then
	git clone https://github.com/gcapizzi/nvim-lua.git ~/.config/nvim
fi
