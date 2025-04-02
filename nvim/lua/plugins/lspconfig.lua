local function setup_lsp(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
        return
    end

    if client:supports_method('textDocument/completion') then
        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    client.server_capabilities.semanticTokensProvider = nil

    if client.name == 'gopls' then
        vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = '*.go',
            callback = function()
                local params = vim.lsp.util.make_range_params(0, 'utf-8')
                params.context = { only = { 'source.organizeImports' } }
                -- buf_request_sync defaults to a 1000ms timeout. Depending on your
                -- machine and codebase, you may want longer. Add an additional
                -- argument after params if you find that you have to write the file
                -- twice for changes to be saved.
                -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
                local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)
                for cid, res in pairs(result or {}) do
                    for _, r in pairs(res.result or {}) do
                        if r.edit then
                            local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
                            vim.lsp.util.apply_workspace_edit(r.edit, enc)
                        end
                    end
                end
                vim.lsp.buf.format({ async = false })
            end,
        })
    end

    vim.api.nvim_create_autocmd('BufWritePre', { callback = function() vim.lsp.buf.format({ async = false }) end })
end

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'nvimtools/none-ls.nvim' },
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
                callback = setup_lsp,
            })

            local lspconfig = require('lspconfig')

            lspconfig.gdscript.setup {}
            lspconfig.gopls.setup {
                settings = {
                    gopls = {
                        linksInHover = false,
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            }

            lspconfig.zls.setup {
                settings = {
                    zls = {
                        semantic_tokens = 'none',
                        enable_snippets = false,
                        warn_style = true,
                        enable_build_on_save = true,
                        -- build_on_save_args = { '-Dno-bin', 'test' },
                    },
                },
            }

            local nls = require('null-ls')
            nls.setup {
                sources = {
                    nls.builtins.diagnostics.fish,
                    -- nls.builtins.diagnostics.golangci_lint,
                    nls.builtins.code_actions.gomodifytags,
                    nls.builtins.code_actions.impl,
                },
            }

            local join = vim.fs.joinpath
            local runtime_path = vim.split(package.path, ';')
            table.insert(runtime_path, join('lua', '?.lua'))
            table.insert(runtime_path, join('lua', '?', 'init.lua'))

            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        telemetry = false,
                        runtime = { version = 'LuaJIT', path = runtime_path,
                        },
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
                                indent_style = 'space',
                                indent_size = '2',
                                quote_style = 'single',
                                call_arg_parentheses = 'keep',
                                trailing_table_separator = 'smart',
                                align_array_table = 'false',
                            },
                        },
                    },
                },
            }
        end,
    },
}
