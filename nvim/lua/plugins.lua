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

  use 'ellisonleao/gruvbox.nvim'

  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'

  use 'blankname/vim-fish'
  use 'neovim/nvim-lspconfig'
  
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local treesitter = require('nvim-treesitter.install')
      local ts_update = treesitter.update({ with_sync = true })
      ts_update()
    end,
  }

  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = 'nvim-lua/plenary.nvim',
  }
  use 'nvim-telescope/telescope-ui-select.nvim'

  use 'luochen1990/rainbow'
  use 'clojure-vim/clojure.vim'
  use { 'guns/vim-sexp',
    setup = function()
    end
  }
  use 'tpope/vim-sexp-mappings-for-regular-people'
  use 'Olical/conjure'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern={'plugins.lua'},
  command='PackerCompile',
})
