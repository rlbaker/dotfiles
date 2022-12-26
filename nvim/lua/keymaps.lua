local keymaps = {}

local telescope = require('telescope.builtin')

keymaps.setup = function()
  vim.g.mapleader = ' '
  vim.g.maplocalleader=','

  local opts = { noremap = true, silent = true }

  --- close all helper windows
  vim.keymap.set('n', '<Leader>q', function()
    vim.cmd('pclose')
    vim.cmd('cclose')
    vim.cmd('lclose')
    vim.cmd('helpclose')
  end, opts)

  vim.keymap.set('n', '<Leader><Leader>', telescope.buffers, opts)
  vim.keymap.set('n', '<Leader>.', telescope.find_files, opts)
  vim.keymap.set('n', '<Leader>m', telescope.marks, opts)
  vim.keymap.set('n', '<Leader>c', telescope.commands, opts)

  vim.keymap.set('n', '<Leader>/', telescope.live_grep, opts)
  vim.keymap.set('n', '<LocalLeader>/', telescope.current_buffer_fuzzy_find)

  vim.keymap.set('n', '<Leader>r', ':TSToggle rainbow<CR>', opts)
  vim.keymap.set('n', '<Leader>t', ':%s/\\s\\+$//e<CR>', opts) -- trim whitespace

  vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<Leader>D', telescope.diagnostics, opts)
  vim.keymap.set('n', '<Leader>[', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<Leader>]', vim.diagnostic.goto_next, opts)

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'clojure',
    callback = function(args)
      local bufopts = { silent=true, buffer=args.buf }
      vim.keymap.set('n', '>(', '<Plug>(sexp_emit_head_element)', bufopts)
      vim.keymap.set('n', '<)', '<Plug>(sexp_emit_tail_element)', bufopts)
      vim.keymap.set('n', '>)', '<Plug>(sexp_capture_next_element)', bufopts)
      vim.keymap.set('n', '<(', '<Plug>(sexp_capture_prev_element)', bufopts)
      vim.keymap.set('n', '>I', '<Plug>(sexp_insert_at_list_tail)', bufopts)
      vim.keymap.set('n', '<I', '<Plug>(sexp_insert_at_list_head)', bufopts)
      vim.keymap.set('n', '(', '<Plug>(sexp_move_to_prev_bracket)', bufopts)
      vim.keymap.set('n', ')', '<Plug>(sexp_move_to_next_bracket)', bufopts)
    end
  })
end

-- function code_action(kind)
--   return function()
--     vim.lsp.buf.code_action({context = { only = { kind } } })
--   end
-- end

keymaps.lsp = function(bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set('n', 'gd', telescope.lsp_definitions, bufopts)
  vim.keymap.set('n', 'gr', telescope.lsp_references, bufopts)
  vim.keymap.set('n', 'gi', telescope.lsp_implementations, bufopts)

  vim.keymap.set('n', '<LocalLeader>R', vim.lsp.buf.rename, bufopts)

  -- vim.keymap.set('n', '<LocalLeader>D', vim.lsp.buf.declaration, bufopts)
  -- vim.keymap.set('n', '<LocalLeader>s', telescope.lsp_document_symbols, bufopts)
  -- vim.keymap.set('n', '<LocalLeader>S', telescope.lsp_dynamic_workspace_symbols, bufopts)

  vim.keymap.set('n', '<LocalLeader>f', function()
    vim.lsp.buf.format { async = true }
  end, bufopts)

  vim.keymap.set('n', '<LocalLeader>o', function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end, bufopts)

  vim.keymap.set('n', '<LocalLeader>a', vim.lsp.buf.code_action, bufopts)
  -- action types
  -- quickfix
  -- refactor
  -- refactor.extract
  -- refactor.inline
  -- refactor.rewrite
  -- source
  -- source.organizeImports
  -- vim.keymap.set('n', '<LocalLeader>aq', code_action('quickfix'), bufopts)
end

return keymaps
