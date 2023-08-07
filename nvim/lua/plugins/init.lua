return {
    {
        'sainnhe/everforest',
        lazy = true,
        priority = 1000,
        init = function()
            vim.g.everforest_diagnostic_virtual_text = 'highlight'
            vim.g.everforest_disable_terminal_colors = 1
            vim.g.everforest_better_performance = 1
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        opts = { sections = { lualine_x = { 'encoding', 'filetype' } } },
    },
    { 'dstein64/vim-startuptime', cmd = 'StartupTime', init = function() vim.g.startuptime_tries = 10 end },
    { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = { check_ts = true } },
    { 'tpope/vim-repeat', event = 'VeryLazy' },
    { 'tpope/vim-commentary', event = 'VeryLazy' },
    { 'tpope/vim-surround', event = 'VeryLazy' },
    { 'tpope/vim-fugitive', cmd = 'Git' },
    { 'ziglang/zig.vim', ft = 'zig', init = function() vim.g.zig_fmt_autosave = 0 end },
}
