function nvim-update
  mkdir -p ~/.nvim-nightly
  pushd ~/.nvim-nightly

  ./nvim-osx64/bin/nvim -v | head -n1 # version before

  curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
  tar xzf nvim-macos.tar.gz || echo "failed to download nightly release"

  ./nvim-osx64/bin/nvim -v | head -n1 # version after

  popd
end
