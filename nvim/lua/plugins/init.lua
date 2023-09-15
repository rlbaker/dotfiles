return {
    {
        'sainnhe/everforest',
        priority = 1000,
        init = function()
            vim.g.everforest_better_performance = 1
            vim.g.everforest_diagnostic_virtual_text = 'highlight'
            vim.g.everforest_disable_terminal_colors = 1
            vim.g.everforest_sign_column_background = 'grey'
            vim.cmd [[colorscheme everforest]]
            vim.api.nvim_set_hl(0, 'MatchParen', { fg = '#FF0000' })
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        opts = { sections = { lualine_x = { 'encoding', 'filetype' } } },
    },
    { 'tpope/vim-fugitive', cmd = 'Git' },
    { 'kylechui/nvim-surround', version = '*', event = 'VeryLazy', opts = {} },
    { 'echasnovski/mini.trailspace', version = '*', event = 'BufWritePre', opts = {} },
    { 'echasnovski/mini.comment', version = '*', opts = {}, keys = { { 'gc', mode = { 'n', 'v' }, { 'gcc' } } } },
    { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = { check_ts = true } },
    { 'ziglang/zig.vim', ft = 'zig', init = function() vim.g.zig_fmt_autosave = 0 end },
}
