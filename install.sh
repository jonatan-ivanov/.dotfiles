#! /bin/sh

relink() {
	if [ -f "$2" ] || [ -d "$2" ]; then mv "$2" "$2.$(date -u +'%Y-%m-%dT%H:%M:%SZ').bak"; fi
	ln -s "$1" "$2"
}

relink "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"
relink "$HOME/.dotfiles/git/.gitconfig" "$HOME/.gitconfig"
relink "$HOME/.dotfiles/aws" "$HOME/.aws"
relink "$HOME/.dotfiles/procs/.procs.toml" "$HOME/.procs.toml"
mkdir -p "$HOME/.config/nvim"; relink "$HOME/.dotfiles/nvim/init.vim" "$HOME/.config/nvim/init.vim"
mkdir -p ~/.config/nvim/bundle; git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
mkdir -p "$HOME/.config/httpie"; relink "$HOME/.dotfiles/httpie/config.json" "$HOME/.config/httpie/config.json"
mkdir -p "$HOME/.config/ghostty"; relink "$HOME/.dotfiles/ghostty/config" "$HOME/.config/ghostty/config"
mkdir -p "$HOME/.gradle/init.d"; relink "$HOME/.dotfiles/gradle/init.d/mirakle_init.gradle" "$HOME/.gradle/init.d/mirakle_init.gradle"
