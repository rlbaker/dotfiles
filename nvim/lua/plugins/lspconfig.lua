-- gross hackery to emulate goimports
local function goimports()
    local clients = vim.lsp.buf_get_clients()

    for _, client in pairs(clients) do
        local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
        params.context = { only = { 'source.organizeImports' } }

        local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 3000)
        for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
                else
                    vim.lsp.buf.execute_command(r.command)
                end
            end
        end
    end
end

local function lsp_mappings(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client ~= nil then
        client.server_capabilities.semanticTokensProvider = nil
    end

    vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'gd', '<Cmd>Telescope lsp_definitions<CR>', opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gR', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gi', '<Cmd>Telescope lsp_implementations<CR>', opts)
    vim.keymap.set('n', 'gr', '<Cmd>Telescope lsp_references<CR>', opts)
    vim.keymap.set('n', 'gs', '<Cmd>Telescope lsp_document_symbols<CR>', opts)
    vim.keymap.set('n', '<LocalLeader>t', '<Cmd>Telescope lsp_type_definitions<CR>', opts)
    vim.keymap.set('n', '<LocalLeader>s', '<Cmd>Telescope lsp_document_symbols<CR>', opts)
    vim.keymap.set('n', '<LocalLeader>i', '<Cmd>Telescope lsp_incoming_calls<CR>', opts)
    vim.keymap.set('n', '<LocalLeader>o', '<Cmd>Telescope lsp_outgoing_calls<CR>', opts)
    vim.keymap.set('n', '<LocalLeader>s', '<Cmd>Telescope lsp_workspace_symbols<CR>', opts)
    vim.keymap.set('n', '<LocalLeader>S', '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>', opts)
    vim.keymap.set({ 'n', 'v', 'x' }, 'ga', vim.lsp.buf.code_action, opts)
    vim.keymap.set('i', '<C-a>', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', 'go', function()
        vim.lsp.buf.code_action {
            context = { only = { 'source.organizeImports' } },
            apply = true,
        }
    end, opts)

    vim.keymap.set('n', 'gf', function()
        vim.lsp.buf.format { async = true }
    end, opts)

    -- organize go imports on save
    vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.go',
        group = vim.api.nvim_create_augroup('GoImports', { clear = true }),
        callback = goimports,
    })

    -- format on save
    vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function() vim.lsp.buf.format { async = false } end,
    })
end


return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local lspconfig = require('lspconfig')

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
            callback = lsp_mappings,
        })

        lspconfig.gopls.setup {
            settings = {
                gopls = {
                    linksInHover = false,
                    gofumpt = true,
                    staticcheck = true,
                },
            },
        }

        lspconfig.zls.setup {
            settings = {
                include_at_in_builtins = true,
                enable_autofix = false,
                warn_style = true,
            },
        }

        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    completion = { keywordSnippet = 'Disable' },
                    diagnostics = { globals = { 'vim' } },
                    runtime = { version = 'LuaJIT' },
                    workspace = { library = { vim.env.VIMRUNTIME } },
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
}
