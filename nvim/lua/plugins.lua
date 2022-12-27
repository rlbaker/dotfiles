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

  use 'clojure-vim/clojure.vim'
  use 'luochen1990/rainbow'
  use 'guns/vim-sexp'
  use 'tpope/vim-sexp-mappings-for-regular-people'
  
  use {
    'Olical/conjure',
    setup = function()
      vim.g['conjure#client_on_load'] = false

      vim.g['conjure#eval#inline_results'] = false
      vim.g['conjure#extract#tree_sitter#enabled'] = true
      vim.g['conjure#filetypes'] = { 'clojure' }
      vim.g['conjure#client#clojure#nrepl#connection#auto_repl#enabled'] = false

      vim.g['conjure#log#botright'] = true
      vim.g['conjure#log#hud#height'] = 0.66
      vim.g['conjure#log#jump_to_latest#cursor_scroll_position'] = 'center'
      vim.g['conjure#log#jump_to_latest#enabled'] = true
      vim.g['conjure#log#wrap'] = true
      
      -- disable some default mappings
      vim.g['conjure#mapping#log_split'] = 'cls'
      vim.g['conjure#mapping#log_vsplit'] = 'clv'
      vim.g['conjure#mapping#log_tab'] = 'clt'
      vim.g['conjure#mapping#log_buf'] = 'clb'
      vim.g['conjure#mapping#log_toggle'] = 'clg'
      vim.g['conjure#mapping#log_reset_soft'] = 'clr'
      vim.g['conjure#mapping#log_reset_hard'] = 'clR'
      vim.g['conjure#mapping#log_jump_to_latest'] = 'cll'
      vim.g['conjure#mapping#log_close_visible'] = 'clq'

      -- disable features provided by clojure-lsp
      vim.g['conjure#completion#omnifunc'] = false
      vim.g['conjure#mapping#def_word'] = false
      vim.g['conjure#mapping#doc_word'] = false
    end,
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern={'plugins.lua'},
  command='PackerCompile',
})
