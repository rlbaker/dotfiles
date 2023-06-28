return {
  'sainnhe/gruvbox-material',
  lazy = true,
  priority = 1000,
  init = function()
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
  end,
  config = function()
  end,
}
