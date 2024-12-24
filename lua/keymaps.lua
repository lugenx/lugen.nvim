-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', ':Explore<CR>', { desc = 'Open Netrw' })
-- vim.keymap.set('n', '<leajer>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[Harpoon]]
-- Marking the current file
vim.api.nvim_set_keymap('n', '<leader>hm', ":lua require('harpoon.mark').add_file()<CR>",
  { noremap = true, silent = true })

-- Navigating to marked files
vim.api.nvim_set_keymap('n', '<leader>h1', ":lua require('harpoon.ui').nav_file(1)<CR>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h2', ":lua require('harpoon.ui').nav_file(2)<CR>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h3', ":lua require('harpoon.ui').nav_file(3)<CR>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h4', ":lua require('harpoon.ui').nav_file(4)<CR>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h5', ":lua require('harpoon.ui').nav_file(5)<CR>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h6', ":lua require('harpoon.ui').nav_file(6)<CR>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h7', ":lua require('harpoon.ui').nav_file(7)<CR>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h8', ":lua require('harpoon.ui').nav_file(8)<CR>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h9', ":lua require('harpoon.ui').nav_file(9)<CR>",
  { noremap = true, silent = true })
-- Toggling the Harpoon menu
vim.api.nvim_set_keymap('n', '<leader>hl', ":lua require('harpoon.ui').toggle_quick_menu()<CR>",
  { noremap = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Key binding to toggle Undotree
vim.api.nvim_set_keymap('n', '<leader>u', ':UndotreeToggle<CR>', { noremap = true, silent = true })

-- vim: ts=2 sts=2 sw=2 et
