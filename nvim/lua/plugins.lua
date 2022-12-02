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

  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
  use 'ntpeters/vim-better-whitespace'

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

  use 'blankname/vim-fish'
  use 'Olical/conjure'
  use { 'eraserhd/parinfer-rust', run = 'cargo build --release' }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.api.nvim_create_autocmd('BufWritePost', { pattern={'plugins.lua'}, command='PackerCompile' })
