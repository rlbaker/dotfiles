return {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
    },
    keys = {
        { '<Leader><Leader>', '<Cmd>Telescope buffers<CR>' },
        { '<Leader>.', '<Cmd>Telescope find_files<CR>' },
        { '<Leader>m', '<Cmd>Telescope marks<CR>' },
        { '<Leader>r', '<Cmd>Telescope registers<CR>' },
        { '<Leader>/', '<Cmd>Telescope current_buffer_fuzzy_find<CR>' },
        { '<Leader>d', '<Cmd>Telescope diagnostics<CR>' },
    },
    config = function()
        local telescope = require('telescope')
        telescope.setup {
            defaults = {
                layout_strategy = 'vertical',
                layout_config = { prompt_position = 'top' },
                mappings = {
                    i = { ['<ESC>'] = require('telescope.actions').close },
                },
                sorting_strategy = 'ascending',
            },
            pickers = { buffers = { sort_lastused = true } },
        }
        telescope.load_extension('ui-select')
    end,
}
