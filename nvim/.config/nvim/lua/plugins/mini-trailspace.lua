return {
  'echasnovski/mini.trailspace',
  version = false,
  config = function()
    require('mini.trailspace').setup()
    vim.keymap.set('n',
      '<leader>sws',
      '<cmd>lua MiniTrailspace.trim()<cr><cmd>lua MiniTrailspace.trim_last_lines()<cr>',
      { desc = 'Trim all trailing whitespace and all trailing empty lines' }
    )
  end
}
