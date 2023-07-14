function update-zls
  echo "updating zig language server"
  pushd ~/src/zig/zls
  git pull
  zig build -Doptimize=ReleaseFast
  popd
end
