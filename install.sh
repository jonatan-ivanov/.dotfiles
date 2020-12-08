#! /bin/sh

relink() {
    if [ -f "$2" ] || [ -d "$2" ]; then mv "$2" "$2.$(date -u +'%Y-%m-%dT%H:%M:%SZ').bak"; fi
    ln -s "$1" "$2"
}

relink "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"
# relink "$HOME/.dotfiles/hyper/.hyper.js" "$HOME/.hyper.js"
# relink "$HOME/.dotfiles/git/.gitconfig" "$HOME/.gitconfig"
