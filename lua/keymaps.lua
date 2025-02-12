-- [[ Basic Keymaps ]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Don't move half screen when i do ctrl+d and ctrl+u, thats too much, just move 10 lines
vim.keymap.set({ "n", "v" }, "<C-d>", "10jzz", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-u>", "10kzz", { noremap = true, silent = true })

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

-- Register group names with which-key
-- Register mappings with which-key using the new specification
require('which-key').add({
  { '<leader>c',   group = 'Code' },
  { '<leader>c_',  hidden = true },
  { '<leader>d',   group = 'Document' },
  { '<leader>d_',  hidden = true },
  { '<leader>g',   group = 'Git' },
  { '<leader>gh',  group = 'Git Hunk' },
  { '<leader>gh_', hidden = true },
  { '<leader>h',   group = 'Harpoon' },
  { '<leader>h1',  desc = 'Nav to File 1' },
  { '<leader>h2',  desc = 'Nav to File 2' },
  { '<leader>h3',  desc = 'Nav to File 3' },
  { '<leader>h4',  desc = 'Nav to File 4' },
  { '<leader>h5',  desc = 'Nav to File 5' },
  { '<leader>h6',  desc = 'Nav to File 6' },
  { '<leader>h7',  desc = 'Nav to File 7' },
  { '<leader>h8',  desc = 'Nav to File 8' },
  { '<leader>h9',  desc = 'Nav to File 9' },
  { '<leader>hl',  desc = 'List Files' },
  { '<leader>hm',  desc = 'Mark File' },
  { '<leader>n',   desc = "Org Roam" },
  { '<leader>o',   desc = "Org Mode" },
  { '<leader>p',   desc = 'Prettier' },
  { '<leader>r',   group = 'Rename' },
  { '<leader>r_',  hidden = true },
  { '<leader>s',   group = 'Search' },
  { '<leader>s_',  hidden = true },
  { '<leader>t',   group = 'Toggle' },
  { '<leader>t_',  hidden = true },
  { '<leader>u',   ':UndotreeToggle<CR>', desc = 'Toggle Undo Tree' },
  { '<leader>w',   group = 'Workspace' },
  { '<leader>w_',  hidden = true },
})

-- Visual mode mappings using the new specification
require('which-key').add({
  { '<leader>',   group = 'VISUAL <leader>', mode = 'v' },
  { '<leader>gh', desc = 'Git Hunk',         mode = 'v' },
})

-- vim: ts=2 sts=2 sw=2 et
