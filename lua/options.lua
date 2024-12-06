-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Custom directory navigation commands
vim.api.nvim_create_user_command('Cont', 'cd $HOME/code/contributions', {})
vim.api.nvim_create_user_command('Gist', 'cd $HOME/code/gists', {})
vim.api.nvim_create_user_command('Proj', 'cd $HOME/code/projects', {})
vim.api.nvim_create_user_command('Temp', 'cd $HOME/code/temp', {})
vim.api.nvim_create_user_command('Trai', 'cd $HOME/code/training', {})


--  Increase distance between line numbers and edge
vim.wo.numberwidth = 4

--  Always open Netrw with Tree style
vim.g.netrw_liststyle = 3

--  Set the shell option - neovim can read .bash_profile file
vim.opt.shell = "/bin/bash -l"

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true


-- No line numbers in Neovim terminal
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "setlocal nonumber norelativenumber"
})

-- Tab size
vim.opt.tabstop = 4

vim.opt.shiftwidth = 4

vim.opt.expandtab = true

-- always 8 line padding on top and bottom
vim.opt.scrolloff = 8

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- vim: ts=2 sts=2 sw=2 et
