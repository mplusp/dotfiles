return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      section_separators = { left = '', right = '' },
      component_separators = '',
      disabled_filetypes = {
        statusline = {},
        winbar = { 'NvimTree' },
      },
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {
        { 'mode', separator = { left = '' } }
      },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = {
        '%=',
        'buffers',
      },
      lualine_x = {},
      lualine_y = {
       { 'filename',
          symbols = {
            modified = '●',
            readonly = '󰌾',
            unnamed = '[No Name]',
            newfile = '[New]',
          }
        },
        'filetype',
        'encoding',
        { 'fileformat', separator = { right = '█' }, }
      },
      lualine_z = {
        'progress',
        { 'location', separator = { right = '' }, },
      },
    },
    inactive_sections = {},
    tabline = {},
    winbar = {
      lualine_a = { '%f' }
    },
    inactive_winbar = {
      lualine_a = { '%f' }
    },
    extensions = {},
  }
}
