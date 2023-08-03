return {
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        opts = {
            sections = { lualine_x = { 'filetype' } },
        },
    },

    { 'tpope/vim-repeat', event = 'VeryLazy' },
    { 'tpope/vim-commentary', event = 'VeryLazy' },
    { 'tpope/vim-surround', event = 'VeryLazy' },
    { 'tpope/vim-fugitive', cmd = 'Git' },
    { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = { check_ts = true } },
    { 'ziglang/zig.vim', ft = 'zig' },
}
