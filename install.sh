#!/usr/bin/env sh

set -euo pipefail

CONFIG_DIR="$HOME/.config"

case $1 in
    asdf)
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1
        mkdir -p ~/.config/fish/completions
        ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
        asdf plugin-add direnv
        asdf direnv setup --shell fish --version latest
        ;;
    nvim)
        mkdir -p "$CONFIG_DIR/nvim"
        mkdir -p "$CONFIG_DIR/nvim/lua/plugins"
        fd --type file --extension lua . nvim --exec ln -vs "$(pwd)/{}" "$HOME/.config/{}"
        ;;
    fish)
        mkdir -p "$CONFIG_DIR/fish"
        mkdir -p "$CONFIG_DIR/fish/functions"
        touch "$CONFIG_DIR/fish/local.fish"
        fd --type file --extension fish . fish --exec ln -vs "$(pwd)/{}" "$CONFIG_DIR/{}"
        ;;
    kitty)
        mkdir -p "$CONFIG_DIR/kitty"
        fd --type file . kitty --exec ln -vs "$(pwd)/{}" "$CONFIG_DIR/{}"
        ;;
    wezterm)
        mkdir -p "$CONFIG_DIR/wezterm"
        fd --type file --extension lua . wezterm --exec ln -vs "$(pwd)/{}" "$HOME/.config/{}"
        ;;
    homebrew)
        mkdir -p "$CONFIG_DIR/homebrew"
        fd --type file . homebrew --exec ln -vs "$(pwd)/{}" "$CONFIG_DIR/{}"
esac
