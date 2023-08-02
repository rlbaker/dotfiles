#!/usr/bin/env sh

pkglist=(
esbenp.prettier-vscode
golang.go
sainnhe.everforest
timonwong.shellcheck
vscodevim.vim
ziglang.vscode-zig
)

for i in ${pkglist[@]}; do
  codium --install-extension $i
done
