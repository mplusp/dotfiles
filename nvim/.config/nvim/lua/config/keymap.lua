-- Navigate visual lines
vim.keymap.set({'n', 'x'}, 'j', 'gj', { desc = 'Navigate down (visual line)' })
vim.keymap.set({'n', 'x'}, 'k', 'gk', { desc = 'Navigate up (visual line)' })
vim.keymap.set({'n', 'x'}, '<Down>', 'gj', { desc = 'Navigate down (visual line)' })
vim.keymap.set({'n', 'x'}, '<Up>', 'gk', { desc = 'Navigate up (visual line)' })
vim.keymap.set('i', '<Down>', '<C-\\><C-o>gj', { desc = 'Navigate down (visual line)' })
vim.keymap.set('i', '<Up>', '<C-\\><C-o>gk', { desc = 'Navigate up (visual line)' })

-- Easier saving
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = 'Save'} )

-- Easier interaction with the system clipboard
vim.keymap.set({'n', 'x'}, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set({'n', 'x'}, '<leader>p', '"+p', { desc = 'Paste from system clipboard after the cursor position' })
vim.keymap.set({'n', 'x'}, '<leader>P', '"+P', { desc = 'Paste from system clipboard before the cursor position' })

-- Navigating buffers
vim.keymap.set('n', '<leader>bb', '<C-^>', { desc = 'Switch to alternate buffer' })
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })