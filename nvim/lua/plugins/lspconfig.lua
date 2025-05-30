local function setup_lsp(args)
  local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

  if client:supports_method('textDocument/completion') then
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
  end

  -- client.server_capabilities.semanticTokensProvider = nil

  if client.name == 'gopls' then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
      buffer = args.buf,
      callback = function()
        local params = vim.lsp.util.make_range_params(0, 'utf-8')
        ---@diagnostic disable-next-line: inject-field
        params.context = { only = { 'source.organizeImports' } }

        -- buf_request_sync defaults to a 1000ms timeout. Depending on your
        -- machine and codebase, you may want longer. Add an additional
        -- argument after params if you find that you have to write the file
        -- twice for changes to be saved.
        -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)

        local result = vim.lsp.buf_request_sync(args.buf, 'textDocument/codeAction', params)
        for _, res in pairs(result or {}) do
          for _, r in pairs(res.result or {}) do
            if r.edit then
              local enc = client.offset_encoding or 'utf-16'
              vim.lsp.util.apply_workspace_edit(r.edit, enc)
            end
          end
        end
      end,
    })
  end

  if not client:supports_method('textDocument/willSaveWaitUntil')
      and client:supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
      end,
    })
  end
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'nvimtools/none-ls.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = setup_lsp,
      })

      vim.lsp.config('ols', { cmd = { '/Users/rlbaker/src/odin/tools/ols/ols' } })

      vim.lsp.config('gopls', {
        settings = {
          gopls = {
            linksInHover = false,
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      local nls = require('null-ls')
      vim.lsp.config('null-ls', {
        sources = {
          nls.builtins.diagnostics.fish,
          nls.builtins.diagnostics.golangci_lint,
          nls.builtins.code_actions.gomodifytags,
          nls.builtins.code_actions.impl,
        },
      })

      local join = vim.fs.joinpath
      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, join('lua', '?.lua'))
      table.insert(runtime_path, join('lua', '?', 'init.lua'))

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            telemetry = false,
            runtime = { version = 'LuaJIT', path = runtime_path },
            diagnostics = { globals = { 'vim' } },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                vim.fn.stdpath('config'),
                '${3rd}/luv/library',
              },
            },
            format = {
              enable = true,
              defaultConfig = {
                indent_size = '2',
                quote_style = 'single',
                trailing_table_separator = 'smart',
                -- align_array_table = 'false',
              },
            },
          },
        },
      })

      vim.lsp.enable({ 'buf_ls', 'gdscript', 'gopls', 'lua_ls', 'ols' })
    end,
  },
}
