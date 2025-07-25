local function setup_lsp(args)
  local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

  if client:supports_method('textDocument/completion') then
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
  end

  if client.name == 'ts_ls' then
    client.server_capabilities.documentFormattingProvider = false;
  end

  if client.name == 'gopls' then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
      buffer = args.buf,
      callback = function()
        local params = vim.lsp.util.make_range_params(0, 'utf-8')
        ---@diagnostic disable-next-line: inject-field
        params.context = { only = { 'source.organizeImports' } }

        local result = vim.lsp.buf_request_sync(args.buf, 'textDocument/codeAction', params, 1000)
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
    dependencies = { 'nvim-lua/plenary.nvim', 'nvimtools/none-ls.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach',
        { group = vim.api.nvim_create_augroup('my.lsp', {}), callback = setup_lsp })

      vim.lsp.config('ols', {
        cmd = { '/Users/rlbaker/src/odin/tools/ols/ols' },
        init_options = {
          checker_args = '-strict-style -vet',
          enable_document_symbols = true,
          enable_fake_methods = true,
          enable_format = true,
          enable_hover = true,
          enable_inlay_hints = false,
          enable_procedure_snippet = true,
          enable_references = true,
          enable_rename = true,
          enable_semantic_tokens = true,
          enable_snippets = true,
        },
      })

      vim.lsp.config('gopls', {
        settings = {
          gopls = {
            linksInHover = false,
            staticcheck = true,
            gofumpt = true,
            semanticTokens = true,
          },
        },
      })


      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.fish,
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.code_actions.gomodifytags,
          null_ls.builtins.code_actions.impl,
          null_ls.builtins.formatting.biome,
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
            diagnostics = { globals = { 'vim', 'Snacks' } },
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
                align_array_table = 'false',
              },
            },
          },
        },
      })

      vim.lsp.enable({ 'gdscript', 'gopls', 'lua_ls', 'ols', 'ts_ls', 'biome' })
    end,
  },
}
