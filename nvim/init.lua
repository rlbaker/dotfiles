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
vim.g.no_racket_maps = true

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

require('which-key').add {
    { '<C-Space>', '<C-X><C-O>', desc = 'Completion', mode = { 'i' } },

    { '<Leader><Leader>', '<Cmd>Telescope buffers<CR>', desc = 'Buffer List' },
    { '<Leader>.', '<Cmd>Telescope find_files<CR>', desc = 'Find Files' },
    { '<Leader>/', '<Cmd>Telescope current_buffer_fuzzy_find<CR>', desc = 'Fuzzy Find in Buffer' },
    { '<Leader>s', '<Cmd>lua MiniTrailspace.trim()<CR>', desc = 'Trim Trailing Whitespace' },

    { '<Leader>d', '<Cmd>Telescope diagnostics<CR>', desc = 'Diagnostic List' },
    { '<Leader>[', vim.diagnostic.goto_prev, desc = 'Prev Diagnostic' },
    { '<Leader>]', vim.diagnostic.goto_next, desc = 'Next Diagnostic' },

    { '\\', '<Cmd>noh<CR>', desc = 'Clear Search Highlights' },
    { '<Esc>', '<C-\\><C-n>', desc = 'Leave Terminal Input Mode', mode = { 't' } },
}
