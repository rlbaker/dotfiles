#!/usr/bin/env bash

set -euo pipefail

dir=$(basename "$PWD")
if [ "$dir" != "dotfiles" ]; then
    echo "error: execute install.sh from within the dotfiles directory"
    exit 1
fi

link_config () {
    [ -z "$1" ] && echo "must provide src" && exit 1
    [ -z "$2" ] && echo "must provide dst" && exit 1

    src_file=$1
    dst_file=$2
    dst_dir=$(dirname "$dst_file")

    # create config directory
    if [ ! -d "$dst_dir" ]; then
        mkdir -p "$dst_dir"
        echo "created: $dst_dir"
    fi

    # symlink file
    if [ ! -f "$dst_file" ]; then
        ln -s "$src_file" "$dst_file"
        echo "linked: $src_file -> $dst_file"
    fi
}

CONFIG_DIR="$HOME/.config"

case "${1:-help}" in
    fish)
        link_config "$PWD/fish/config.fish" "$CONFIG_DIR/fish/config.fish"
        link_config "$PWD/fish/colors.fish" "$CONFIG_DIR/fish/colors.fish"
        link_config "$PWD/fish/functions/fish_title.fish" "$CONFIG_DIR/fish/functions/fish_title.fish"
        link_config "$PWD/fish/functions/fish_prompt.fish" "$CONFIG_DIR/fish/functions/fish_prompt.fish"
        link_config "$PWD/fish/functions/fish_right_prompt.fish" "$CONFIG_DIR/fish/functions/fish_right_prompt.fish"
        link_config "$PWD/fish/functions/fish_user_key_bindings.fish" "$CONFIG_DIR/fish/functions/fish_user_key_bindings.fish"
        touch "$CONFIG_DIR/fish/local.fish"
        ;;
    neovim)
        link_config "$PWD/neovim/init.vim" "$CONFIG_DIR/nvim/init.vim"
        ;;
    vim)
        link_config "$PWD/vim/vimrc" "$HOME/.vim/vimrc"
        ;;
    alacritty)
        link_config "$PWD/alacritty/alacritty.yml" "$CONFIG_DIR/alacritty/alacritty.yml"
        ;;
    tmux)
        link_config "$PWD/tmux/tmux.conf" "$CONFIG_DIR/tmux/tmux.conf"
        ;;
    brew)
        link_config "$PWD/brew/Brewfile" "$CONFIG_DIR/brew/Brewfile"
        ;;
    *)
        echo "./install [ alacritty | fish | brew | nvim | tmux ]"
        ;;
esac
