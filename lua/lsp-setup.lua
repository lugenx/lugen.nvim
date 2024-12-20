-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
-- [[ Configure LSP ]]
local on_attach = function(_, bufnr)
  -- Helper function for LSP mappings
  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  -- LSP keymaps
  nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
  nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
  nmap('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
  nmap('gr', require('telescope.builtin').lsp_references, 'Goto Reference')
  -- ... other LSP mappings ..

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

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

-- Rest of your LSP and mason configurations
-- ... (no changes needed here) ...

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  gopls = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
  -- pyright = {},
  -- rust_analyzer = {},
  ts_ls = {},
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  cssls = {},
  jsonls = {},
  eslint = {},
  stylelint_lsp = {},
  svelte = {},
  marksman = {}, -- for markdown
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
  jdtls = {}, -- for java
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
