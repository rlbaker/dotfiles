return {
    {
        'nvim-treesitter/nvim-treesitter',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = { 'RRethy/nvim-treesitter-endwise' },
        build = function()
            local update = require('nvim-treesitter.install').update { with_sync = true }
            update()
        end,
        config = function()
            require('nvim-treesitter.configs').setup {
                auto_install = true,
                ensure_installed = { 'bash', 'fish', 'go', 'lua', 'vim' },
                highlight = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<C-Space>',
                        node_incremental = '<C-Space>',
                        scope_incremental = false,
                        node_decremental = '<BS>',
                    },
                },
                endwise = { enable = true },
            }
        end,
    },
}
