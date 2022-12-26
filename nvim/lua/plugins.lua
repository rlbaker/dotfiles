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
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
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
  -- use 'p00f/nvim-ts-rainbow'

  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = 'nvim-lua/plenary.nvim',
  }
  use 'nvim-telescope/telescope-ui-select.nvim'

  use {
    'guns/vim-sexp',
    setup = function()
      vim.g.sexp_filetypes = '' -- remove default mappings
    end,
  }
  
  -- use {
  --   'Olical/conjure',
  --   setup = function()
  --     vim.g['conjure#client_on_load'] = false
  --     vim.g['conjure#filetypes'] = { 'clojure' }
  --     vim.g['conjure#extract#tree_sitter#enabled'] = true
  --     vim.g['conjure#log#botright'] = true
  --     vim.g['conjure#log#wrap'] = true
  --     vim.g['conjure#log#hud#height'] = 0.66
  --     vim.g['conjure#log#jump_to_latest#enabled'] = true
  --     vim.g['conjure#log#jump_to_latest#cursor_scroll_position'] = 'center'
  --     vim.g['conjure#client#clojure#nrepl#connection#auto_repl#enabled'] = false
  --     vim.g['conjure#eval#inline_results'] = false
  --   end,
  -- }

  -- use {
  --   'eraserhd/parinfer-rust',
  --   run = 'cargo build --release',
  -- }


  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern={'plugins.lua'},
  command='PackerCompile',
})
