vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.mouse = 'a'
vim.opt.shortmess:append { W = true, I = true, c = true, C = true }
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.signcolumn = 'no'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitkeep = 'screen'
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.wildmode = { 'longest:full', 'full' }

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- bootstrap package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system {
        'git', 'clone', '--filter=blob:none', '--single-branch',
        'https://github.com/folke/lazy.nvim.git', lazypath,
    }
end
vim.opt.runtimepath:prepend(lazypath)
require('lazy').setup('plugins', { change_detection = { enabled = false } })

vim.keymap.set('n', '<Leader>q', [[ :pclose | cclose | lclose | helpclose<CR> ]])
vim.keymap.set('n', '<Leader>[', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<Leader>]', vim.diagnostic.goto_next)
vim.keymap.set('n', '\\', ':noh<CR>')
vim.keymap.set('v', '<Leader>y', '"+y') -- copy to clipboard
vim.keymap.set('n', '<Leader>p', '"+p') -- paste from clipboard
vim.keymap.set('i', '<C-Space>', '<C-X><C-O>')

vim.api.nvim_create_augroup('rlb', { clear = true })

local trim = function() vim.cmd [[ :%s/\s\+$//e ]] end
vim.api.nvim_create_autocmd('BufWritePre', { group = 'rlb', pattern = '*', callback = trim })

local formatoptions = function() vim.opt.formatoptions:remove { 'c', 'r', 'o' } end
vim.api.nvim_create_autocmd('FileType', { group = 'rlb', pattern = '*', callback = formatoptions })

local tabs = function() vim.opt.expandtab = false end
vim.api.nvim_create_autocmd('FileType', { group = 'rlb', pattern = 'go', callback = tabs })

vim.g.html_indent_autotags = 'html'
vim.g.loaded_python3_provider = 0
vim.g.zig_fmt_autosave = 0
