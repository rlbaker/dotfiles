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
vim.opt.termguicolors = true
vim.opt.wildmode = { 'longest:full', 'full' }
vim.opt.switchbuf = { 'useopen', 'uselast' }
vim.opt.updatetime = 1000
vim.opt.timeout = true
vim.opt.timeoutlen = 500

vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.g.html_indent_autotags = 'html'
vim.g.loaded_python3_provider = 0

-- bootstrap package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git', 'clone', '--filter=blob:none', '--single-branch',
        'https://github.com/folke/lazy.nvim.git', lazypath,
    }
end
vim.opt.runtimepath:prepend(lazypath)
require('lazy').setup('plugins')

local rlb = vim.api.nvim_create_augroup('rlb', { clear = true })

vim.api.nvim_create_autocmd('FileType', { group = rlb, pattern = '*', command = [[ set formatoptions-=cro ]] })
vim.api.nvim_create_autocmd('FileType', { group = rlb, pattern = 'go', command = [[ set noexpandtab ]] })
vim.api.nvim_create_autocmd('FileType', { group = rlb, pattern = 'zig', command = [[ set iskeyword-=@-@ ]] })
vim.api.nvim_create_autocmd(
    { 'BufNewFile', 'BufRead' },
    { group = rlb, pattern = 'justfile', command = [[ setfiletype just ]] }
)
