require('plugins')

local opts = { noremap=true, silent=true }

vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.mouse = 'a'
vim.opt.shiftwidth = 0
vim.opt.shortmess:append 'cI'
vim.opt.smartcase = true
vim.opt.softtabstop = -1
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = 'no'
vim.opt.wildmode = {'longest:full', 'full'}
vim.opt.termguicolors = true
vim.g.html_indent_autotags = 'html,head,body'

vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = -1

vim.keymap.set('i', '<Tab>', '<C-t>', opts)
vim.keymap.set('i', '<S-Tab>', '<C-d>', opts)

vim.g['conjure#filetypes'] = { 'clojure' }
vim.g['conjure#extract#tree_sitter#enabled'] = true
vim.g['conjure#log#botright'] = true
vim.g['conjure#log#wrap'] = true
vim.g['conjure#log#hud#height'] = 0.75
vim.g['conjure#highlight#enabled'] = true
vim.g['conjure#log#jump_to_latest#cursor_scroll_position'] = 'bottom'

vim.keymap.set('n', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader=','

require('gruvbox').setup({
  italic = false,
  overrides = {
    SignColumn = { bg = '#504945' },
    NormalFloat = { bg = '#504945' },
  }
})
vim.cmd [[colorscheme gruvbox]]

--- disable comment continuations
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
      vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end
})

vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function()
    require('lint').try_lint()
  end,
})


-- telescope config
require('telescope').setup {
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      prompt_position = 'top',
    },
    path_display = { 'shorten' },
    sorting_strategy = 'ascending'
  },
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      sort_mru = true,
    }
  }
}

local telescope = require('telescope.builtin')
--- close all helper windows
vim.keymap.set('n', '<Leader>q', ':pclose | cclose | lclose | helpclose<CR>', opts)
vim.keymap.set('n', '<Leader>t', ':%s/\\s\\+$//e<CR>', opts)
vim.keymap.set('n', '<Leader><Leader>', telescope.buffers, opts)
vim.keymap.set('n', '<Leader>.', telescope.find_files, opts)
vim.keymap.set('n', '<Leader>/', telescope.live_grep, opts)
vim.keymap.set('n', '<LocalLeader>/', telescope.current_buffer_fuzzy_find)
vim.keymap.set('n', '<Leader>m', telescope.marks, opts)
vim.keymap.set('n', '<Leader>c', telescope.commands, opts)

-- lsp specific mappings
vim.keymap.set('n', '<LocalLeader>q', telescope.diagnostics, opts)
vim.keymap.set('n', '<LocalLeader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)


-- lsp
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<LocalLeader>d', telescope.lsp_definitions, bufopts)
  vim.keymap.set('n', '<LocalLeader>D', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<LocalLeader>r', telescope.lsp_references, bufopts)
  vim.keymap.set('n', '<LocalLeader>R', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<LocalLeader>s', telescope.lsp_document_symbols, bufopts)
  vim.keymap.set('n', '<LocalLeader>S', telescope.lsp_dynamic_workspace_symbols, bufopts)
  vim.keymap.set('n', '<LocalLeader>i', telescope.lsp_implementations, bufopts)
  vim.keymap.set('n', '<LocalLeader>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<LocalLeader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<LocalLeader>o', function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end, bufopts)
end

require('lspconfig').gopls.setup {
  on_attach = on_attach,
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
    }
  }
}

require('nvim-treesitter.configs').setup {
  auto_install = false,
  ensure_installed = { 'clojure', 'go', 'help', 'lua', 'vim' },
  highlight = { enable = true }
}
