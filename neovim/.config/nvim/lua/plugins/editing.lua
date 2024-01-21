return {
  {
    'nvim-treesitter/nvim-treesitter',
    main = 'nvim-treesitter.configs',
    dependencies = {
      'RRethy/nvim-treesitter-endwise',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    event = { 'BufReadPre', 'BufNew', 'BufNewFile' },
    cmd = {
      'TSBufDisable',
      'TSBufEnable',
      'TSBufToggle',
      'TSConfigInfo',
      'TSDisable',
      'TSEditQuery',
      'TSEditQueryUserAfter',
      'TSEnable',
      'TSInstall',
      'TSInstallFromGrammar',
      'TSInstallInfo',
      'TSInstallSync',
      'TSModuleInfo',
      'TSToggle',
      'TSUninstall',
      'TSUpdate',
      'TSUpdateSync',
    },
    build = function()
      local ts_update =
        require('nvim-treesitter.install').update { with_sync = true }
      ts_update()
    end,
    opts = {
      auto_install = true,
      endwise = { enable = true },
      ensure_installed = {
        'c',
        'jsdoc',
        'lua',
        'luap',
        'markdown_inline',
        'query',
        'regex',
        'vim',
        'vimdoc',
      },
      highlight = { enable = true },
      indent = { enable = true },
      textobjects = {
        lsp_interop = {
          enable = true,
          peek_definition_code = {
            ['<leader>p'] = {
              desc = 'Pick definition',
              query = '@function.outer,@variable',
            },
          },
        },
        move = {
          enable = true,
          goto_next_start = {
            [']f'] = {
              desc = 'Next function start',
              query = '@function.outer',
            },
          },
          goto_previous_start = {
            ['[f'] = {
              desc = 'Previous function start',
              query = '@function.outer',
            },
          },
          goto_next_end = {
            [']F'] = {
              desc = 'Next function end',
              query = '@function.outer',
            },
          },
          goto_previous_end = {
            ['[F'] = {
              desc = 'Previous function end',
              query = '@function.outer',
            },
          },
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = {
              desc = 'a function',
              query = '@function.outer',
            },
            ['if'] = {
              desc = 'inner function',
              query = '@function.inner',
            },
          },
        },
      },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = { 'BufReadPre', 'BufNew', 'BufNewFile' },
    opts = {
      enable_close_on_slash = true,
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = { 'BufReadPre', 'BufNew', 'BufNewFile' },
    cmd = {
      'TSContextDisable',
      'TSContextEnable',
      'TSContextToggle',
    },
    opts = {
      max_lines = 8,
    },
  },
  {
    'windwp/nvim-autopairs',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'InsertEnter',
    opts = {
      break_undo = false,
      check_ts = true,
      disable_filetype = { 'spectre_panel', 'TelescopePrompt' },
    },
  },
  {
    'RRethy/vim-illuminate',
    event = 'LspAttach',
    keys = {
      {
        desc = 'Next Reference',
        ']r',
        function() require('illuminate').goto_next_reference() end,
      },
      {
        desc = 'Previous Reference',
        '[r',
        function() require('illuminate').goto_prev_reference() end,
      },
    },
    opts = {
      providers = { 'lsp' },
    },
    config = function(_, opts) require('illuminate').configure(opts) end,
  },
  { 'Darazaki/indent-o-matic', event = 'BufReadPre', opts = {} },
  { 'farmergreg/vim-lastplace', event = 'BufReadPre' },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      {
        desc = 'Split/Join',
        '<leader>j',
        '<Cmd>TSJToggle<CR>',
      },
    },
    opts = {
      max_join_length = 500,
      use_default_keymaps = false,
    },
  },
  { 'gpanders/nvim-parinfer', ft = { 'dune' } },
  {
    'echasnovski/mini.surround',
    keys = {
      { desc = 'Add surrounding', 'sa', mode = { 'n', 'x' } },
      { desc = 'Delete surrounding', 'sd' },
      { desc = 'Find left surrounding', 'sF' },
      { desc = 'Find right surrounding', 'sf' },
      { desc = 'Highlight surrounding', 'sh' },
      { desc = 'Update `MiniSurround.config.n_lines`', 'sn' },
      { desc = 'Replace surrounding', 'sr' },
    },
    opts = {},
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    lazy = true,
    opts = {},
  },
  {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    keys = {
      { desc = 'Comment toggle current line', 'gcc' },
      { desc = 'Comment toggle linewise (visual)', 'gc', mode = { 'n', 'x' } },
      { desc = 'Comment toggle current block', 'gbc' },
      { desc = 'Comment toggle blockwise (visual)', 'gb', mode = { 'n', 'x' } },
      { desc = 'Comment insert end of line', 'gcA' },
      { desc = 'Comment insert above', 'gcO' },
      { desc = 'Comment insert below', 'gco' },
    },
    opts = function()
      return {
        pre_hook = require(
          'ts_context_commentstring.integrations.comment_nvim'
        ).create_pre_hook(),
      }
    end,
  },
  {
    'rlane/pounce.nvim',
    keys = {
      {
        desc = 'Jump',
        '<leader><leader>',
        '<Cmd>Pounce<CR>',
      },
      {
        desc = 'Repeat Jump',
        '<leader><leader><leader>',
        '<Cmd>PounceRepeat<CR>',
      },
    },
  },
  {
    'NvChad/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNew', 'BufNewFile' },
    cmd = {
      'ColorizerAttachToBuffer',
      'ColorizerDetachFromBuffer',
      'ColorizerReloadAllBuffers',
      'ColorizerToggle',
    },
    opts = {
      user_default_options = {
        css = true,
        RRGGBBAA = true,
        AARRGGBB = true,
      },
    },
  },
  {
    -- TODO: remove once nvim 0.10.0 is released
    -- https://github.com/neovim/neovim/issues/23231
    'chrishrb/gx.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = { { 'gx', '<Cmd>Browse<CR>', mode = { 'n', 'x' } } },
    opts = {
      handlers = {
        brewfile = false,
        github = false,
        package_json = false,
        plugin = false,
        search = false,
      },
    },
  },
}
