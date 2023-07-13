function update-zig
  echo "updating zig compiler"
  asdf uninstall zig master
  and asdf install zig master
  and asdf global zig master

  echo "updating zig language server"
  pushd ~/src/zig/zls
  git pull
  zig build -Doptimize=ReleaseFast
  cp zig-out/bin/zls ~/.local/bin/
  popd
end
