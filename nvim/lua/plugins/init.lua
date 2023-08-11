return {
    {
        'sainnhe/everforest',
        priority = 1000,
        init = function()
            vim.g.everforest_better_performance = 1
            vim.g.everforest_diagnostic_virtual_text = 'highlight'
            vim.g.everforest_disable_terminal_colors = 1
            vim.cmd [[colorscheme everforest]]
            vim.api.nvim_set_hl(0, 'MatchParen', { fg = '#FF0000' })
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        opts = { sections = { lualine_x = { 'encoding', 'filetype' } } },
    },
    { 'dstein64/vim-startuptime', cmd = 'StartupTime', init = function() vim.g.startuptime_tries = 10 end },
    { 'echasnovski/mini.comment', keys = { { 'gc', mode = { 'n', 'v' } }, { 'gcc' } }, opts = {} },
    { 'echasnovski/mini.surround', event = 'VeryLazy', opts = {} },
    { 'echasnovski/mini.trailspace', event = 'BufWritePre', version = '*', opts = {} },
    { 'tpope/vim-fugitive', cmd = 'Git' },
    { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = { check_ts = true } },
    { 'ziglang/zig.vim', ft = 'zig', init = function() vim.g.zig_fmt_autosave = 0 end },
}
