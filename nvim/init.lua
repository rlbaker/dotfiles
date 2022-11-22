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
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
  use 'neovim/nvim-lspconfig'
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = {{'nvim-lua/plenary.nvim'}},
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

--- compile packer configuration after saving init.lua
vim.api.nvim_create_autocmd('BufWritePost', { pattern={'init.lua'}, command='PackerCompile' })

vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.shiftwidth = 0
vim.opt.shortmess:append 'cI'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = -1
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.signcolumn = 'no'
vim.opt.wildmode = {'longest:full', 'full'}
vim.opt.termguicolors = true
vim.g.mapleader = ' '
vim.g.maplocalleader=','
vim.g.html_indent_autotags = 'html,head,body'
vim.g.no_ocaml_maps = true

require('gruvbox').setup({
  italic = false,
  overrides = {
    SignColumn = { bg = '#504945' },
    NormalFloat = { bg = '#32302f' }
  }
})
vim.cmd [[colorscheme gruvbox]]

--- disable comment continuations
vim.api.nvim_create_autocmd('FileType', { pattern='*', command='set formatoptions-=c' })
vim.api.nvim_create_autocmd('FileType', { pattern='css,html,javascript,json,lua,ocaml', command='set tabstop=2' })

-- treesitter
require('nvim-treesitter.configs').setup {
  auto_install = false,
  ensure_installed = { 'go', 'help', 'lua', 'ocaml', 'vim' },
  highlight = { enable = true }
}

-- telescope
local telescope = require('telescope.builtin')

require('telescope').setup {
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      sort_mru = true,
    }
  }
}

local opts = { noremap=true, silent=true }

--- close all helper windows
vim.keymap.set('n', '<Leader>q', ':pclose | cclose | lclose | helpclose<CR>', opts)
vim.keymap.set('n', '<Leader><Leader>', telescope.buffers, opts)
vim.keymap.set('n', '<Leader>.', telescope.find_files, opts)
vim.keymap.set('n', '<Leader>/', telescope.live_grep, opts)
vim.keymap.set('n', '<Leader>m', telescope.marks, opts)
vim.keymap.set('n', '<Leader>c', telescope.commands, opts)

-- lsp specific mappings
vim.keymap.set('n', '<LocalLeader>/', telescope.current_buffer_fuzzy_find)
vim.keymap.set('n', '<LocalLeader>s', telescope.lsp_document_symbols, opts)
vim.keymap.set('n', '<LocalLeader>S', telescope.lsp_workspace_symbols, opts)
vim.keymap.set('n', '<LocalLeader>q', telescope.diagnostics, opts)
vim.keymap.set('n', '<LocalLeader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

-- lsp
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<LocalLeader>d', telescope.lsp_definitions, bufopts)
  vim.keymap.set('n', '<LocalLeader>r', telescope.lsp_references, bufopts)
  vim.keymap.set('n', '<LocalLeader>D', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<LocalLeader>R', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<LocalLeader>i', telescope.lsp_implementations, bufopts)
  vim.keymap.set('n', '<LocalLeader>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<LocalLeader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<LocalLeader>o', function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end, bufopts)
end

require('lspconfig').ocamllsp.setup {
  on_attach = on_attach,
  single_file_support = true
}

require('lspconfig').gopls.setup {
  on_attach = on_attach,
  settings = {
    gopls = {
      gofumpt = true, 
      staticcheck = true,
    }
  }
}
