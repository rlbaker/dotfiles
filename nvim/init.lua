require('plugins')

vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.mouse = 'a'
vim.opt.shortmess:append 'cI'
vim.opt.signcolumn = 'no'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmode = {'longest:full', 'full'}

-- indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.softtabstop = -1
vim.opt.tabstop = 2

vim.g.mapleader = ' '
vim.g.maplocalleader=','
vim.g.html_indent_autotags = 'html,head,body'

vim.opt.termguicolors = true
require('gruvbox').setup({
  italic = false,
  overrides = {
    SignColumn = { bg = '#504945' },
    NormalFloat = { bg = '#504945' },
  }
})
vim.cmd('colorscheme gruvbox')


--- disable comment continuations
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end
})

-- telescope config
local telescope = require('telescope')
telescope.setup {
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
telescope.load_extension("ui-select")

local opts = { noremap = true, silent = true }

--- close all helper windows
vim.keymap.set('n', '<Leader>q', function()
  vim.cmd('pclose')
  vim.cmd('cclose')
  vim.cmd('lclose')
  vim.cmd('helpclose')
end, opts)

local ts = require('telescope.builtin')
vim.keymap.set('n', '<Leader><Leader>', ts.buffers, opts)
vim.keymap.set('n', '<Leader>.', ts.find_files, opts)
vim.keymap.set('n', '<Leader>m', ts.marks, opts)
vim.keymap.set('n', '<Leader>c', ts.commands, opts)

vim.keymap.set('n', '<Leader>/', ts.live_grep, opts)
vim.keymap.set('n', '<LocalLeader>/', ts.current_buffer_fuzzy_find)

vim.keymap.set('n', '<Leader>r', ':RainbowToggle<CR>', opts)
vim.keymap.set('n', '<Leader>t', ':%s/\\s\\+$//e<CR>', opts) -- trim whitespace

vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<Leader>D', ts.diagnostics, opts)
vim.keymap.set('n', '<Leader>[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<Leader>]', vim.diagnostic.goto_next, opts)

require('nvim-treesitter.configs').setup {
  auto_install = false,
  ensure_installed = { 'clojure', 'go', 'help', 'lua', 'vim' },
  highlight = { enable = false },
}

function on_attach(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil
  
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set('n', 'gd', ts.lsp_definitions, bufopts)
  vim.keymap.set('n', 'gr', ts.lsp_references, bufopts)
  vim.keymap.set('n', 'gi', ts.lsp_implementations, bufopts)

  vim.keymap.set('n', '<LocalLeader>R', vim.lsp.buf.rename, bufopts)

  -- vim.keymap.set('n', '<LocalLeader>D', vim.lsp.buf.declaration, bufopts)
  -- vim.keymap.set('n', '<LocalLeader>s', ts.lsp_document_symbols, bufopts)
  -- vim.keymap.set('n', '<LocalLeader>S', ts.lsp_dynamic_workspace_symbols, bufopts)

  vim.keymap.set('n', '<LocalLeader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<LocalLeader>o', function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end, bufopts)

  vim.keymap.set('n', '<LocalLeader>a', vim.lsp.buf.code_action, bufopts)
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

require('lspconfig').clojure_lsp.setup{
  on_attach = on_attach,
  root_dir = function(filename, bufnr)
    -- prevent LSP from attaching to conjure buffer
    if string.match(filename, "conjure%-log%-%d+") then
      return nil
    end
    return require("lspconfig.server_configurations.clojure_lsp").default_config.root_dir(filename, bufnr)
  end,
}

-- vim-sexp
vim.g.sexp_mappings = {
  sexp_insert_at_list_head = 'H',
  sexp_insert_at_list_tail = 'L',
}

-- conjure
vim.g['conjure#client#clojure#nrepl#connection#auto_repl#enabled'] = false
vim.g['conjure#completion#omnifunc'] = false
vim.g['conjure#eval#inline_results'] = false
vim.g['conjure#extract#tree_sitter#enabled'] = true
vim.g['conjure#filetypes'] = { 'clojure' }
vim.g['conjure#mapping#def_word'] = false
vim.g['conjure#mapping#doc_word'] = false
vim.g['conjure#log#botright'] = true
vim.g['conjure#log#hud#height'] = 0.66
vim.g['conjure#log#jump_to_latest#cursor_scroll_position'] = 'center'
vim.g['conjure#log#jump_to_latest#enabled'] = true
vim.g['conjure#log#wrap'] = true

-- rainbow parens
vim.g.rainbow_active = 1
vim.g.rainbow_conf = {
  guifgs = {
    '#7C6F64', -- grey
    '#B57614', -- yellow
    '#427B58', -- aqua
    '#8F3F71', -- purple
    '#076678', -- blue
    '#AF3A03', -- orange
    '#79740E', -- green
  },
}
