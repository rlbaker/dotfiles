vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- bootstrap package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git', 'clone',
    '--filter=blob:none', '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup('plugins', {
  ui = {
    icons = {
      cmd = '⌘', config = '🛠', event = '📅',
      ft = '📂', init = '⚙', keys = '🗝',
      plugin = '🔌', runtime = '💻', source = '📄',
      start = '🚀', task = '📌',
    }
  }
})

vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
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
vim.opt.wildmode = { 'longest:full', 'full' }

-- indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.softtabstop = -1
vim.opt.tabstop = 2

vim.g.html_indent_autotags = 'html,head,body'

--- disable comment continuations
vim.api.nvim_create_augroup('rlb', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'rlb',
  pattern = '*',
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = 'rlb',
  pattern = { '*' },
  command = [[%s/\s\+$//e]],
})

local opts = { noremap = true, silent = true }

--- close all helper windows
vim.keymap.set('n', '<Leader>q', function()
  vim.cmd('pclose')
  vim.cmd('cclose')
  vim.cmd('lclose')
  vim.cmd('helpclose')
end, opts)

-- vim.keymap.set('n', '<Leader>t', ':%s/\\s\\+$//e<CR>', opts) -- trim whitespace

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<Leader><Leader>', telescope.buffers, opts)
vim.keymap.set('n', '<Leader>.', telescope.find_files, opts)
vim.keymap.set('n', '<Leader>m', telescope.marks, opts)
vim.keymap.set('n', '<Leader>:', telescope.commands, opts)

vim.keymap.set('n', '<Leader>/', telescope.live_grep, opts)
vim.keymap.set('n', '<LocalLeader>/', telescope.current_buffer_fuzzy_find)

vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<Leader>D', telescope.diagnostics, opts)
vim.keymap.set('n', '<Leader>[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<Leader>]', vim.diagnostic.goto_next, opts)

local function on_attach(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set('n', 'gd', telescope.lsp_definitions, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gr', telescope.lsp_references, bufopts)
  vim.keymap.set('n', 'gi', telescope.lsp_implementations, bufopts)

  vim.keymap.set('n', 'gR', vim.lsp.buf.rename, bufopts)

  vim.keymap.set('n', '<LocalLeader>ci', telescope.lsp_incoming_calls, bufopts)
  vim.keymap.set('n', '<LocalLeader>co', telescope.lsp_outgoing_calls, bufopts)

  vim.keymap.set('n', '<LocalLeader>s', telescope.lsp_document_symbols, bufopts)
  vim.keymap.set('n', '<LocalLeader>S', telescope.lsp_dynamic_workspace_symbols, bufopts)

  vim.keymap.set('n', 'gf', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', 'go', function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end, bufopts)

  vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
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

require('lspconfig').sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      completion = { keywordSnippet = 'Disable' },
      diagnostics = { globals = { 'vim', 'love' } },
      runtime = { version = 'LuaJIT' },
      semantic = { enable = false },
      telemetry = { enable = false },
      format = {
        enable = true,
        defaultConfig = {
          indent_size = '2',
          indent_style = 'space',
          align_call_args = 'true',
          continuation_indent_size = '2',
          -- if_condition_align_with_each_other = 'true',
          if_condition_no_continuation_indent = 'true',
          local_assign_continuation_align_to_first_expression = 'true',
          quote_style = 'single',
          table_append_expression_no_space = 'true',
        },
      }
    },
  },
}

require('lspconfig').clojure_lsp.setup {
  on_attach = on_attach,
  root_dir = function(fname)
    -- prevent LSP from attaching to conjure buffer
    if string.match(fname, 'conjure%-log%-%d+') then return nil end
    return require('lspconfig.server_configurations.clojure_lsp').default_config.root_dir(fname)
  end,
}
