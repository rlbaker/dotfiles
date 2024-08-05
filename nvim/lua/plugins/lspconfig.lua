local function goimports()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { 'source.organizeImports' } }
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 1500)
    for cid, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
            end
        end
    end
end

local function lsp_config(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
        return
    end

    client.server_capabilities.semanticTokensProvider = nil

    local wk = require('which-key')
    wk.add {
        {
            buffer = args.buf,
            { 'K', vim.lsp.buf.hover, desc = 'LSP Hover' },
            { '<C-k>', vim.lsp.buf.signature_help, desc = 'Signature Help', mode = { 'i' } },
            { '<LocalLeader>', group = 'LSP' },
            { '<LocalLeader>a', vim.lsp.buf.code_action, desc = 'Code Actions', mode = { 'n', 'v', 'x' } },
            { '<LocalLeader>d', '<Cmd>Telescope lsp_definitions<CR>', desc = 'Go to Definition' },
            { '<LocalLeader>D', vim.lsp.buf.declaration, desc = 'Go to Declaration' },
            { '<LocalLeader>f', function() vim.lsp.buf.format { async = true } end, desc = 'Format' },
            { '<LocalLeader>i', '<Cmd>Telescope lsp_implementations<CR>', desc = 'Go to Implementation' },
            { '<LocalLeader>I', '<Cmd>Telescope lsp_incoming_calls<CR>', desc = 'Incoming Calls' },
            { '<LocalLeader>O', '<Cmd>Telescope lsp_outgoing_calls<CR>', desc = 'Outgoing Calls' },
            { '<LocalLeader>r', '<Cmd>Telescope lsp_references<CR>', desc = 'List References' },
            { '<LocalLeader>R', vim.lsp.buf.rename, desc = 'List References' },
            { '<LocalLeader>s', '<Cmd>Telescope lsp_document_symbols<CR>', desc = 'Document Symbols' },
            { '<LocalLeader>S', '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>', desc = 'Workspace Symbols' },
            { '<LocalLeader>t', '<Cmd>Telescope lsp_type_definitions<CR>', desc = 'Go to Type Definition' },
            { '<LocalLeader>lr', '<Cmd>lua vim.lsp.codelens.refresh()<CR>', desc = 'Refresh Code Lens' },
            { '<LocalLeader>la', '<Cmd>lua vim.lsp.codelens.run()<CR>', desc = 'Run Code Lens' },
            {
                '<LocalLeader>h',
                function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 }) end,
                desc = 'Toggle Inlay Hints',
            },
            {
                '<LocalLeader>o',
                function()
                    vim.lsp.buf.code_action {
                        context = {
                            diagnostics = {},
                            only = { 'source.organizeImports' },
                        },
                        apply = true,
                    }
                end,
                desc = 'Organize Imports',
            },
            {
                mode = { 'i' },
                { '<C-a>', vim.lsp.buf.code_action, desc = 'Code Actions' },
            },
        },
    }

    -- organize go imports on save
    vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.go',
        group = vim.api.nvim_create_augroup('GoImports', { clear = true }),
        callback = goimports,
    })

    -- format on save
    vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
            -- vim.lsp.buf.format { async = false }
            vim.lsp.buf.format { timeout = 1000 }
            vim.diagnostic.show(nil, args.buf)
        end,
    })
end

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'nvimtools/none-ls.nvim' },
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
                callback = lsp_config,
            })

            local lspconfig = require('lspconfig')

            lspconfig.gopls.setup {
                settings = {
                    linksInHover = false,
                    staticcheck = true,
                    analyses = {
                        unusedvariable = true,
                        useany = true,
                    },
                    semanticTokens = true,
                },
            }

            lspconfig.zls.setup {
                cmd = { 'zls', '--log-level', 'warn' },
                settings = {
                    enable_snippets = false,
                    enable_build_on_save = true,
                    build_on_save_step = 'check',
                },
            }

            lspconfig.sourcekit.setup {
                capabilities = {
                    workspace = {
                        didChangeWatchedFiles = {
                            dynamicRegistration = true,
                        },
                    },
                },
            }
            lspconfig.clangd.setup { cmd = { 'clangd', '--log=error' } }

            lspconfig.lua_ls.setup {
                -- Support completion for Neovim lua libraries
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
                        return
                    end
                end,
                settings = {
                    Lua = {
                        completion = { keywordSnippet = 'Disable' },
                        diagnostics = { globals = { 'vim' } },
                        runtime = { version = 'LuaJIT' },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                                '${3rd}/luv/library',
                            },
                        },
                        format = {
                            enable = true,
                            defaultConfig = {
                                indent_style = 'space',
                                quote_style = 'single',
                                call_arg_parentheses = 'remove_table_only',
                                trailing_table_separator = 'smart',
                                align_array_table = 'false',
                            },
                        },
                    },
                },
            }

            local nls = require('null-ls')
            nls.setup {
                sources = {
                    nls.builtins.code_actions.gomodifytags,
                    nls.builtins.code_actions.impl,
                    nls.builtins.diagnostics.fish,
                    nls.builtins.diagnostics.golangci_lint,
                    nls.builtins.diagnostics.swiftlint,
                    nls.builtins.formatting.swift_format,
                },
            }
        end,
    },
}
