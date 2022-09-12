local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer = require('packer')
local use = packer.use
packer.startup(function()
    use 'wbthomason/packer.nvim'
    use 'dstein64/vim-startuptime'
    use 'ellisonleao/gruvbox.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-commentary'
    use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}}}
    use { 'nvim-treesitter/nvim-treesitter', run = function() require('nvim-treesitter.install').update({ with_sync = true }) end, }
    use 'ziglang/zig.vim'
end)

vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.mouse = 'a'
vim.opt.shiftwidth = 0
vim.opt.shortmess:append 'cI'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = -1
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.wildmode = {'longest:full', 'full'}
vim.opt.termguicolors = true
-- vim.opt.signcolumn = 'yes'
vim.opt.background = 'dark'
vim.g.mapleader = ' '
vim.g.maplocalleader=','
vim.g.html_indent_autotags = 'html,head,body'
vim.g.gruvbox_sign_column = 'bg2'
vim.g.gruvbox_invert_tabline = 1

require("gruvbox").setup({ italic = false })
vim.cmd [[colorscheme gruvbox]]

--- disable comment continuations
vim.api.nvim_create_autocmd('FileType', {pattern='*', command='set formatoptions-=cro'})

--- compile packer configuration after saving init.lua
vim.api.nvim_create_autocmd('BufWritePost', { pattern={'init.lua'}, command='PackerCompile' })


--- close all helper windows
vim.api.nvim_set_keymap('n', '<Leader>q', ':pclose <Bar> cclose <Bar> lclose <Bar> helpclose<CR>', {noremap=true, silent=true})

-- telescope config
local tele = require'telescope.builtin'
vim.api.nvim_set_keymap('n', '<Leader>f', '', { callback=tele.find_files, noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<Leader><Leader>', '', { callback=tele.buffers, noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<Leader>/', '', { callback=tele.live_grep, noremap=true, silent=true })

require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'c', 'cpp', 'lua', 'go', 'toml', 'yaml',
        'python', 'css', 'html', 'javascript',
        'bash', 'fish', 'make', 'json', 'ninja',
        'zig',
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
