--  Increase distance between line numbers and edge
vim.wo.numberwidth = 4

--  Always open Netrw with Tree style
vim.g.netrw_liststyle = 3

-- Hide netrwTreeListing file and .git directory from Netrw
vim.g.netrw_list_hide = [[netrwTreeListing$,^\.git/$]]
vim.opt.wildignore:append({ "netrwTreeListing", ".git" })

-- sort directories first then files alphabetically
vim.g.netrw_sort_sequence = "[\\/],*"

-- This code fixes "the ctrl ^ opens emtpy buffer when last buffer is netrw" issue. Will keep it like this untill I find better solution.
vim.keymap.set("n", "<C-^>", function()
  local alt_buf = vim.fn.bufnr("#")
  if alt_buf > 0
      and vim.api.nvim_buf_is_valid(alt_buf)
      and vim.api.nvim_buf_is_loaded(alt_buf)
  then
    local ft = vim.api.nvim_buf_get_option(alt_buf, "filetype")
    local name = vim.api.nvim_buf_get_name(alt_buf)
    if ft ~= "netrw" and not name:match("netrwTreeListing") then
      vim.cmd("buffer #")
      return
    end
  end

  -- Fallback: sort buffers by recency (ignoring netrw)
  local current = vim.api.nvim_get_current_buf()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  local candidates = {}
  for _, buf in ipairs(bufs) do
    local ft = vim.api.nvim_buf_get_option(buf.bufnr, "filetype")
    local name = vim.api.nvim_buf_get_name(buf.bufnr)
    if buf.bufnr ~= current and ft ~= "netrw" and not name:match("netrwTreeListing") then
      table.insert(candidates, buf)
    end
  end

  if #candidates == 0 then
    print("No alternate code buffer available")
    return
  end

  table.sort(candidates, function(a, b)
    return a.lastused > b.lastused
  end)
  vim.cmd("buffer " .. candidates[1].bufnr)
end, { noremap = true, silent = true })
----

--  Set the shell option - neovim can read .bash_profile file
vim.opt.shell = "/bin/bash -l"

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Disable to respect terminals blinking settings
vim.opt.guicursor = ""

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
