vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.mouse = 'a'
vim.opt.shortmess:append { W = true, I = true, c = true }
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.signcolumn = 'no'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitkeep = 'screen'
vim.opt.splitright = true
vim.opt.wildmode = { 'longest:full', 'full' }
vim.opt.switchbuf = { 'useopen', 'uselast' }
vim.opt.updatetime = 1000
vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.foldenable = false
-- vim.opt.foldlevelstart = 99

vim.g.html_indent_autotags = 'html'
vim.g.loaded_python3_provider = 0

vim.g.zig_fmt_autosave = 0
vim.g.zig_fmt_parse_errors = 0

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system {
        'git', 'clone', '--filter=blob:none', '--single-branch',
        'https://github.com/folke/lazy.nvim.git', lazypath,
    }
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup { { import = 'plugins' } }

local rlb = vim.api.nvim_create_augroup('rlb', { clear = true })
vim.api.nvim_create_autocmd('FileType', { group = rlb, pattern = '*', command = [[ set fo-=cro ]] })
vim.api.nvim_create_autocmd('FileType', { group = rlb, pattern = 'go', command = [[ set noet ]] })
vim.api.nvim_create_autocmd('FileType', { group = rlb, pattern = 'zig', command = [[ set iskeyword-=@-@ ]] })
vim.api.nvim_create_autocmd('LspAttach', {
    group = rlb,
    callback = function()
        vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, { desc = 'LSP Hover' })
    end,
})

vim.keymap.set('i', '<C-Space>', '<C-X><C-O>', { desc = 'Completion' })
vim.keymap.set('n', '<Leader><Leader>', '<Cmd>Telescope buffers<CR>', { desc = 'Buffer List' })
vim.keymap.set('n', '<Leader>.', '<Cmd>Telescope find_files<CR>', { desc = 'List Files' })
vim.keymap.set('n', '<Leader>s', '<Cmd>lua MiniTrailspace.trim()<CR>', { desc = 'Trim Trailing Whitespace' })
vim.keymap.set('n', '\\', '<Cmd>noh<CR>', { desc = 'Clear Search Highlights' })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Leave Terminal Input Mode' })
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Help' })
vim.keymap.set('n', '<LocalLeader>D', vim.lsp.buf.declaration, { desc = 'Declarations' })
vim.keymap.set('n', '<LocalLeader>R', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<LocalLeader>f', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format' })
vim.keymap.set('n', '<Leader>d', '<Cmd>Telescope diagnostics<CR>', { desc = 'Diagnostic List' })
vim.keymap.set('n', '<LocalLeader>d', '<Cmd>Telescope lsp_definitions<CR>', { desc = 'Go to Definition' })
vim.keymap.set('n', '<LocalLeader>i', '<Cmd>Telescope lsp_implementations<CR>', { desc = 'Go to Implementation' })
vim.keymap.set('n', '<LocalLeader>I', '<Cmd>Telescope lsp_incoming_calls<CR>', { desc = 'Incoming Calls' })
vim.keymap.set('n', '<LocalLeader>O', '<Cmd>Telescope lsp_outgoing_calls<CR>', { desc = 'Outgoing Calls' })
vim.keymap.set('n', '<LocalLeader>r', '<Cmd>Telescope lsp_references<CR>', { desc = 'List References' })
vim.keymap.set('n', '<LocalLeader>s', '<Cmd>Telescope lsp_document_symbols<CR>', { desc = 'Document Symbols' })
vim.keymap.set('n', '<LocalLeader>S', '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>', { desc = 'Workspace Symbols' })
vim.keymap.set('n', '<LocalLeader>t', '<Cmd>Telescope lsp_type_definitions<CR>', { desc = 'Go to Type Definition' })
vim.keymap.set('n', '<LocalLeader>A', vim.lsp.buf.code_action, { desc = 'Code Actions' })
vim.keymap.set('n', '<LocalLeader>a', function()
    vim.lsp.buf.code_action({
        filter = function(action)
            return action.kind ~= 'gopls.doc.features' and action.kind ~= 'source.doc'
        end,
    })
end, { desc = 'Code Actions' })

vim.diagnostic.config({ virtual_lines = true })
