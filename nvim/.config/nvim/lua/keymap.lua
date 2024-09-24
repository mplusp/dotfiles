-- Have j and k/up and down navigate visual lines rather than logical ones
vim.keymap.set('n', 'j', 'gj', {})
vim.keymap.set('n', 'k', 'gk', {})
vim.keymap.set('n', '<Down>', 'gj', {})
vim.keymap.set('n', '<Up>', 'gk', {})
