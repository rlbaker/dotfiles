return {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    event = 'LspAttach',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
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
            pickers = {
                buffers = {
                    sort_lastused = true,
                    sort_mru = true,
                },
            },
        }
        telescope.load_extension('ui-select')
    end,
}
