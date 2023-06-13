vim.opt.termguicolors = true

vim.opt.mouse = 'a'
vim.opt.cursorline = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.shortmess:append 'cI'
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.laststatus = 3
vim.opt.signcolumn = 'no'
vim.opt.confirm = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.wildmode = { 'longest:full', 'full' }

-- indentation
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.g.loaded_python3_provider = 0
vim.g.html_indent_autotags = 'html,head,body'

-- bootstrap package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system {
        'git', 'clone', '--filter=blob:none', '--single-branch',
        'https://github.com/folke/lazy.nvim.git', lazypath,
    }
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup('plugins', {
    ui = {
        icons = {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
})

local rlb = vim.api.nvim_create_augroup('rlb', { clear = true })

-- disable comment continuations
vim.api.nvim_create_autocmd('FileType', {
    group = rlb,
    pattern = '*',
    callback = function()
        vim.opt.formatoptions:remove { 'c', 'r', 'o' }
    end,
})

vim.keymap.set('n', '\\', ':noh<CR>')
vim.keymap.set('n', '<Leader>q', [[ :pclose | cclose | lclose | helpclose<CR> ]])
vim.keymap.set('n', '<Leader>h', ':bp<CR>')
vim.keymap.set('n', '<Leader>l', ':bn<CR>')

local function trim() vim.cmd [[ :%s/\s\+$//e ]] end
vim.api.nvim_create_autocmd('BufWritePre', { group = rlb, pattern = '*', callback = trim })
vim.keymap.set('n', '<Leader>t', trim)

local ts = require('telescope.builtin')
vim.keymap.set('n', '<Leader>.', ts.find_files)
vim.keymap.set('n', '<Leader><Leader>', ts.buffers)
vim.keymap.set('n', '<Leader>m', ts.marks)
vim.keymap.set('n', '<Leader>r', ts.registers)
vim.keymap.set('n', '<Leader>/', ts.current_buffer_fuzzy_find)
vim.keymap.set('n', '<Leader>d', ts.diagnostics)
vim.keymap.set('n', '<Leader>[', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<Leader>]', vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd('LspAttach', {
    group = rlb,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil

        local buf = args.buf
        vim.bo[buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = buf }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', 'gd', ts.lsp_definitions, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gt', ts.lsp_type_definitions, opts)
        vim.keymap.set('n', 'gi', ts.lsp_implementations, opts)
        vim.keymap.set('n', 'gr', ts.lsp_references, opts)
        vim.keymap.set('n', 'gs', ts.lsp_document_symbols, opts)
        vim.keymap.set('n', 'gci', ts.lsp_incoming_calls, opts)
        vim.keymap.set('n', 'gco', ts.lsp_outgoing_calls, opts)
        vim.keymap.set('n', 'gR', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', 'gf', function() vim.lsp.buf.format { async = true } end, opts)
        vim.keymap.set({ 'n', 'v' }, 'ga', vim.lsp.buf.code_action, opts)
    end,
})

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            completion = { keywordSnippet = 'Disable' },
            diagnostics = { globals = { 'vim' } },
            runtime = { version = 'LuaJIT' },
            format = {
                enable = true,
                defaultConfig = {
                    quote_style = 'single',
                    call_arg_parentheses = 'remove_table_only',
                    trailing_table_separator = 'smart',
                    align_array_table = 'false',
                },
            },
        },
    },
}

lspconfig.gopls.setup {
    on_attach = function(_, buf)
        local gopls_fmt = function()
            vim.lsp.buf.format()
            vim.lsp.buf.code_action {
                context = { only = { 'source.organizeImports' } },
                apply = true,
            }
        end
        vim.keymap.set('n', 'gf', gopls_fmt, { buffer = buf })
    end,
    settings = {
        gopls = {
            linksInHover = false,
            staticcheck = true,
            analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedvariable = true,
                unusedwrite = true,
                useany = true,
            },
        },
    },
}
