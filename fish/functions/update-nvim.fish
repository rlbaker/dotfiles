function update-nvim
  mkdir -p ~/.nvim-nightly
  pushd ~/.nvim-nightly

  ./nvim-macos/bin/nvim -v | head -n1 # version before
  curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz | tar x
  ./nvim-macos/bin/nvim -v | head -n1 # version after

  popd
end
