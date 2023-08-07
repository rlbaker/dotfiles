return {
    { 'sainnhe/everforest', lazy = true },
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        opts = { sections = { lualine_x = { 'encoding', 'filetype' } } },
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = { check_ts = true },
    },
    { 'tpope/vim-repeat', event = 'VeryLazy' },
    { 'tpope/vim-commentary', event = 'VeryLazy' },
    { 'tpope/vim-surround', event = 'VeryLazy' },
    { 'tpope/vim-fugitive', cmd = 'Git' },
    { 'ziglang/zig.vim', ft = 'zig' },
}
