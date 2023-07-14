function update-zig
  echo "updating zig compiler"
  asdf uninstall zig master
  and asdf install zig master
  and asdf global zig master

  echo "updating zig language server"
  pushd ~/src/zig/zls
  zig build -Doptimize=ReleaseFast
  popd
end
