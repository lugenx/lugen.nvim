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
  sqlls = {},
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

for server_name, config in pairs(servers) do
  require('lspconfig')[server_name].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = config,
    filetypes = (config or {}).filetypes,
  }
end
-- vim: ts=2 sts=2 sw=2 et
