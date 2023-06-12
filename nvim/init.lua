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
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        }
    }
})

local ts = require('telescope.builtin')

vim.keymap.set('n', '\\', ':noh<CR>')

vim.keymap.set('n', '<Leader>q', [[ :pclose | cclose | lclose | helpclose<CR> ]])

local rlb = vim.api.nvim_create_augroup('rlb', { clear = true })

-- disable comment continuations
vim.api.nvim_create_autocmd('FileType', {
    group = rlb,
    pattern = '*',
    callback = function()
        vim.opt.formatoptions:remove { 'c', 'r', 'o' }
    end
})

-- trim whitespace
function TrimWhitespace() vim.cmd [[ :%s/\s\+$//e ]] end

vim.api.nvim_create_autocmd('BufWritePre', { group = rlb, pattern = '*', callback = TrimWhitespace })
vim.keymap.set('n', '<Leader>t', TrimWhitespace)

-- lsp configs

local lsp = require('lspconfig')

local function gopls_fmt()
    vim.lsp.buf.format()
    vim.lsp.buf.code_action {
        context = { only = { 'source.organizeImports' } },
        apply = true
    }
end

local gopls_analyses = {
    fieldalignment = true,
    nilness = true,
    unusedparams = true,
    unusedvariable = true,
    unusedwrite = true,
    useany = true,
}

lsp.gopls.setup {
    on_attach = function(_, buf)
        vim.keymap.set('n', 'gf', gopls_fmt, { buffer = buf })
    end,
    settings = {
        gopls = {
            linksInHover = false,
            staticcheck = true,
            analyses = gopls_analyses,
        }
    }
}

lsp.lua_ls.setup {
    settings = {
        Lua = {
            completion = { keywordSnippet = 'Disable' },
            diagnostics = { globals = { 'vim' } },
            runtime = { version = 'LuaJIT' },
            format = { enable = true },
            -- workspace = {
            --     library = vim.api.nvim_get_runtime_file("", true),
            -- },
        }
    }
}

lsp.clojure_lsp.setup {
  root_dir = function(fname)
    -- prevent LSP from attaching to conjure buffer
    if string.match(fname, 'conjure%-log%-%d+') then return nil end
    return require('lspconfig.util').root_pattern('deps.edn', 'bb.edn', '.git')(fname)
  end,
}

vim.keymap.set('n', '<Leader>f', ts.find_files)
vim.keymap.set('n', '<Leader><Leader>', ts.buffers)
vim.keymap.set('n', '<Leader>m', ts.marks)
-- vim.keymap.set('n', '<Leader>h', ':bp<CR>')
-- vim.keymap.set('n', '<Leader>l', ':bn<CR>')
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
        vim.keymap.set('n', '<Leader>s', ts.lsp_document_symbols, opts)
        vim.keymap.set('n', '<Leader>ci', ts.lsp_incoming_calls, opts)
        vim.keymap.set('n', '<Leader>co', ts.lsp_outgoing_calls, opts)
        vim.keymap.set('n', 'gR', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', 'gf', function() vim.lsp.buf.format { async = true } end, opts)
        vim.keymap.set({ 'n', 'v' }, 'ga', vim.lsp.buf.code_action, opts)
    end,
})
