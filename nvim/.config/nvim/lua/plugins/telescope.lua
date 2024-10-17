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
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope oldfiles' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    vim.keymap.set('n', '<leader>bb', builtin.builtin, { desc = 'Telescope builtin pickers' })
  end
}
