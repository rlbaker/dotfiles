-- local function do_action(kind)
--     return function()
--         vim.lsp.buf.code_action {
--             --- @diagnostic disable-next-line: missing-fields
--             context = { only = kind },
--             apply = true,
--         }
--     end
-- end

local function code_actions()
    vim.lsp.buf.code_action {
        filter = function(action)
            return action.kind ~= 'gopls.doc.features'
        end,
    }
end

local function organize_imports()
    vim.lsp.buf.code_action {
        --- @diagnostic disable-next-line: missing-fields
        context = { only = { 'source.organizeImports' } },
        apply = true,
    }
end

local function set_keymaps(args)
    local wk = require('which-key')
    wk.add { {
        buffer = args.buffer,
        { 'K', vim.lsp.buf.hover, desc = 'LSP Hover' },

        { '<C-k>', vim.lsp.buf.signature_help, desc = 'Signature Help', mode = { 'i' } },
        { '<C-f>', function() vim.lsp.buf.format { async = true } end, desc = 'Format', mode = { 'i' } },

        { '<LocalLeader>', group = 'LSP' },
        { '<LocalLeader>D', vim.lsp.buf.declaration, desc = 'Go to Declaration' },
        { '<LocalLeader>R', vim.lsp.buf.rename, desc = 'List References' },
        { '<LocalLeader>f', function() vim.lsp.buf.format { async = true } end, desc = 'Format' },
        { '<LocalLeader>lr', vim.lsp.codelens.refresh, desc = 'Refresh Code Lens' },
        { '<LocalLeader>la', vim.lsp.codelens.run, desc = 'Run Code Lens' },

        { '<LocalLeader>d', '<Cmd>Telescope lsp_definitions<CR>', desc = 'Go to Definition' },
        { '<LocalLeader>i', '<Cmd>Telescope lsp_implementations<CR>', desc = 'Go to Implementation' },
        { '<LocalLeader>I', '<Cmd>Telescope lsp_incoming_calls<CR>', desc = 'Incoming Calls' },
        { '<LocalLeader>O', '<Cmd>Telescope lsp_outgoing_calls<CR>', desc = 'Outgoing Calls' },
        { '<LocalLeader>r', '<Cmd>Telescope lsp_references<CR>', desc = 'List References' },
        { '<LocalLeader>s', '<Cmd>Telescope lsp_document_symbols<CR>', desc = 'Document Symbols' },
        { '<LocalLeader>S', '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>', desc = 'Workspace Symbols' },
        { '<LocalLeader>t', '<Cmd>Telescope lsp_type_definitions<CR>', desc = 'Go to Type Definition' },

        { '<LocalLeader>a', code_actions, desc = 'Code Actions', mode = { 'n', 'v', 'x' } },
        -- { '<LocalLeader>A', vim.lsp.buf.code_action, desc = 'All Code Actions', mode = { 'n', 'v', 'x' } },
        { '<C-a>', code_actions, desc = 'Code Actions', mode = { 'i' } },
        { '<LocalLeader>o', organize_imports, desc = 'Organize Imports' },
    } }
end

local function setup_lsp(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
        return
    end

    client.server_capabilities.semanticTokensProvider = nil

    set_keymaps(args)

    if client.name == 'gopls' then
        vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = '*.go',
            callback = organize_imports,
        })
    end

    vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function()
            vim.lsp.buf.format()
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
                callback = setup_lsp,
            })

            local lspconfig = require('lspconfig')

            lspconfig.gdscript.setup {}
            lspconfig.racket_langserver.setup {}
            lspconfig.gopls.setup {
                settings = {
                    gopls = {
                        linksInHover = false,
                        staticcheck = true,
                        gofumpt = true,
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

            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME, '${3rd}/luv/library' },
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
        end,
    },
}
