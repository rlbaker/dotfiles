local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'dstein64/vim-startuptime'

  use { 'ellisonleao/gruvbox.nvim' }


  use 'neovim/nvim-lspconfig'
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {{'nvim-lua/plenary.nvim'}},
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local treesitter = require('nvim-treesitter.install')
      local ts_update = treesitter.update({ with_sync = true })
      ts_update()
    end,
  }

  use 'Olical/conjure'
  use { 'eraserhd/parinfer-rust', run = 'cargo build --release' }
  -- use { 'guns/vim-sexp' }
  -- use { 'tpope/vim-sexp-mappings-for-regular-people' }
  use {
    'mfussenegger/nvim-lint',
    config = function()
      require("lint").linters_by_ft = {
        clojure = {"clj-kondo"},
      }
    end
  }

  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
  use 'ntpeters/vim-better-whitespace'
  use 'blankname/vim-fish'

if packer_bootstrap then
  require('packer').sync()
end
end)

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern={'plugins.lua'},
  command='PackerCompile'
})
