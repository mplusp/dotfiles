return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  config = function()
    require('telescope').setup {
      pickers = {
        find_files = {
          -- include hidden files but ignore files in .git directories
          find_command = {
            'rg',
            '--files',
            '--hidden',
            '-g',
            '!.git'
          }
        }
      }
    }
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>bb', builtin.builtin, {})
  end
}
