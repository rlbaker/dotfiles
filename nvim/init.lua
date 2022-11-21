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
  use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}}}
  use { 'nvim-treesitter/nvim-treesitter', run = function() require('nvim-treesitter.install').update({ with_sync = true }) end, }
  use 'neovim/nvim-lspconfig'

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
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.mouse = 'a'
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
vim.opt.background = 'dark'
vim.g.mapleader = ' '
vim.g.maplocalleader=','
vim.g.html_indent_autotags = 'html,head,body'
vim.g.gruvbox_sign_column = 'bg1'
-- vim.g.gruvbox_invert_tabline = 1
vim.g.rainbow_active = 1

require('gruvbox').setup({
  italic = false,
  overrides = {
    SignColumn = { bg = '#504945' },
    NormalFloat = { bg = '#32302f' }
  }
})
vim.cmd [[colorscheme gruvbox]]

--- disable comment continuations
vim.api.nvim_create_autocmd('FileType', {pattern='*', command='set formatoptions-=cro'})
vim.api.nvim_create_autocmd('FileType', {pattern='css,html,javascript,json,lua,ocaml', command='set tabstop=2'})


local opts = { noremap=true, silent=true }

--- close all helper windows
vim.keymap.set('n', '<Leader>q', ':pclose | cclose | lclose | helpclose<CR>', opts)

-- telescope config
local tele = require('telescope.builtin')
vim.keymap.set('n', '<Leader>f', '', { noremap=true, silent=true, callback=tele.find_files })
vim.keymap.set('n', '<Leader><Leader>', '', { noremap=true, silent=true, callback=tele.buffers})
vim.keymap.set('n', '<Leader>/', '', { noremap=true, silent=true, callback=tele.live_grep })

-- treesitter config
require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  auto_install = false,
  ensure_installed = { "lua", "ocaml", "clojure" },
}

-- lsp config
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<LocalLeader>d', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<LocalLeader>D', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<LocalLeader>r', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<LocalLeader>R', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<LocalLeader>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<LocalLeader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<LocalLeader>t', vim.lsp.buf.type_definition, bufopts)
end

-- vim.keymap.set('n', '<LocalLeader>e', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<LocalLeader>q', vim.diagnostic.setloclist, opts)

require'lspconfig'.ocamllsp.setup{
  on_attach = on_attach,
  single_file_support = true,
}

require'lspconfig'.gopls.setup{ on_attach = on_attach }
