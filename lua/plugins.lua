-- [[ Configure plugins ]]
require('lazy').setup({

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
 config = function()
      require('lsp-setup')
    end,
  },
  -- Undo tree visualization plugin
  {
    'mbbill/undotree',
    cmd = "UndotreeToggle",
    config = function()
      -- Set the window layout style to 2 (diff left to right, undotree at the bottom)
      vim.g.undotree_WindowLayout = 2
    end,
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',  opts = {} },


  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require('mini.icons').setup()
    end,
    lazy = true,
  },


  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        map({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to previous hunk' })

        -- Actions
        -- visual mode
        map('v', '<leader>ghs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>ghr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>ghs', gs.stage_hunk, { desc = 'git stage hunk' })
        map('n', '<leader>ghr', gs.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>ghS', gs.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>ghu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
        map('n', '<leader>ghR', gs.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>ghp', gs.preview_hunk, { desc = 'preview git hunk' })
        map('n', '<leader>ghb', function()
          gs.blame_line { full = false }
        end, { desc = 'git blame line' })
        map('n', '<leader>ghd', gs.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>ghD', function()
          gs.diffthis '~'
        end, { desc = 'git diff against last commit' })

        -- Toggles
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
      end,
    },
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'darker' --CUSTOM: There are different versions like 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
      }
      require('onedark').load()
    end,
  },
  --  [[Harpoon]]
  {
    'ThePrimeagen/harpoon', -- Harpoon plugin repository
    config = function()
      -- Any specific configuration for Harpoon can go here
    end
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  {
    "windwp/nvim-autopairs",
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require("nvim-autopairs").setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
  },
  { 'prettier/vim-prettier' },

  -- orgmode nvim
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      require('orgmode').setup({
        org_agenda_files = { '~/org_roam_files/**/*', '~/orgfiles/**/*' },
        org_default_notes_file = '~/orgfiles/refile.org',
      })
      -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
      -- add ~org~ to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },
  -- Org-roam nvim
    {
    "chipsenkbeil/org-roam.nvim",
    dependencies = {
      "nvim-orgmode/orgmode",
    },
    config = function()
      require("org-roam").setup({
        directory = "~/org_roam_files",
        org_files = {
          "~/org_roam_files/**/*.org",
          "~/orgfiles/**/*.org",
        }
      })
    end
  },
  -- hardtime
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {}
  },
})

-- vim: ts=2 sts=2 sw=2 et
