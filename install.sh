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

case "${1:-help}" in
  vim)
    link_config "$PWD/vim/vimrc" "$HOME/.vim/vimrc"
    ;;
  alacritty)
    link_config "$PWD/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
    ;;
  tmux)
    link_config "$PWD/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
    ;;
  bash)
    link_config "$PWD/bash/bash_profile" "$HOME/.bash_profile"
    link_config "$PWD/bash/gruvbox_256palette_osx.sh" "$HOME/.config/bash/gruvbox_256palette_osx.sh"
    ;;
  brew)
    link_config "$PWD/homebrew/Brewfile" "$HOME/.config/homebrew/Brewfile"
    ;;
  *)
    echo "./install [ alacritty | bash | brew | tmux | vim ]"
    ;;
esac


