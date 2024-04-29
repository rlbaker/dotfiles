#!/usr/bin/env sh

set -euo pipefail

CONFIG_DIR="$HOME/.config"

case $1 in
    mise)
        curl https://mise.run | sh
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
    wezterm)
        mkdir -p "$CONFIG_DIR/wezterm"
        fd --type file --extension lua . wezterm --exec ln -vs "$(pwd)/{}" "$HOME/.config/{}"
        ;;
    homebrew)
        mkdir -p "$CONFIG_DIR/homebrew"
        fd --type file . homebrew --exec ln -vs "$(pwd)/{}" "$CONFIG_DIR/{}"
        ;;
esac
