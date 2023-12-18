local settings = {}

settings.gopls = {
    gopls = {
        linksInHover = false,
        gofumpt = true,
        staticcheck = true,
        symbolScope = 'workspace',
        analyses = {
            loopclosure = false,
            unusedparams = true,
            unusedvariable = true,
            unusedwrite = true,
            useany = true,
        },
        codelenses = { gc_details = true },
        templateExtensions = { 'tmpl' },
    },
}

settings.lua_ls = {
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
}

settings.zls = {}

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

local function lsp_mappings(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
        return
    end

    client.server_capabilities.semanticTokensProvider = nil


    vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

    local wk = require('which-key')

    wk.register({
        a = { vim.lsp.buf.code_action, 'Code Actions', mode = { 'n', 'v', 'x' } },
        d = { '<Cmd>Telescope lsp_definitions<CR>', 'Go to Definition' },
        D = { vim.lsp.buf.declaration, 'Go to Declaration' },
        f = { function() vim.lsp.buf.format { async = true } end, 'Format' },
        i = { '<Cmd>Telescope lsp_implementations<CR>', 'Go to Implementation' },
        I = { '<Cmd>Telescope lsp_incoming_calls<CR>', 'Incoming Calls' },
        o = { function()
            vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } }, apply = true }
        end, 'Organize Imports' },
        O = { '<Cmd>Telescope lsp_outgoing_calls<CR>', 'Outgoing Calls' },
        r = { '<Cmd>Telescope lsp_references<CR>', 'List References' },
        R = { vim.lsp.buf.rename, 'List References' },
        s = { '<Cmd>Telescope lsp_document_symbols<CR>', 'Document Symbols' },
        S = { '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>', 'Workspace Symbols' },
        t = { '<Cmd>Telescope lsp_type_definitions<CR>', 'Go to Type Definition' },
        h = { function() vim.lsp.inlay_hint(args.buf) end, 'Toggle Inlay Hints' },
        lr = { '<Cmd>lua vim.lsp.codelens.refresh()<CR>', 'Refresh Code Lens' },
        la = { '<Cmd>lua vim.lsp.codelens.run()<CR>', 'Run Code Lens' },
    }, { prefix = '<LocalLeader>', buffer = args.buf })

    wk.register {
        ['<C-a>'] = { vim.lsp.buf.code_action, 'Code Actions', mode = 'i' },
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
            vim.lsp.buf.format { async = false }
            vim.diagnostic.show(nil, args.buf)
        end,
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

        lspconfig.lua_ls.setup { settings = settings.lua_ls }
        lspconfig.gopls.setup { settings = settings.gopls }
        lspconfig.zls.setup { settings = settings.zls }
    end,
}
