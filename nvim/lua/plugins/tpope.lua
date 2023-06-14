return {
    -- { 'tpope/vim-surround' },
    -- { 'tpope/vim-repeat' },
    {
        'tpope/vim-fugitive',
        cmd = 'Git',
    },
    {
        'tpope/vim-commentary',
        keys = {
            'gcc', 'gcu',
            { 'gc', mode = { 'o', 'n', 'x' } },
        },
    },
}
