return {
  {
    'nvim-treesitter/nvim-treesitter',
    main = 'nvim-treesitter.configs',
    dependencies = {
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
    build = ':TSUpdate',
    opts = {
      auto_install = true,
      ensure_installed = {
        'diff',
        'jsdoc',
        'luap',
        'markdown_inline',
        'regex',
      },
      highlight = { enable = true },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['ac'] = {
              desc = 'A comment',
              query = '@comment.outer',
            },
            ['af'] = {
              desc = 'A function',
              query = '@function.outer',
            },
            ['if'] = {
              desc = 'Inner function',
              query = '@function.inner',
            },
            ['ai'] = {
              desc = 'An if',
              query = '@conditional.outer',
            },
            ['ii'] = {
              desc = 'Inner if',
              query = '@conditional.inner',
            },
            ['al'] = {
              desc = 'A loop',
              query = '@loop.outer',
            },
            ['il'] = {
              desc = 'Inner loop',
              query = '@loop.inner',
            },
          },
        },
      },
    },
  },
  {
    'RRethy/nvim-treesitter-endwise',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = { 'BufReadPre', 'BufNew', 'BufNewFile' },
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
      min_window_height = 30,
      mode = 'topline',
      multiwindow = true,
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = { break_undo = false },
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
    opts = {},
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
    'kylechui/nvim-surround',
    keys = {
      {
        desc = 'Add a surrounding pair around the cursor (insert mode)',
        mode = 'i',
        '<C-g>s',
      },
      {
        desc = 'Add a surrounding pair around the cursor, on new lines (insert mode)',
        mode = 'i',
        '<C-g>S',
      },
      {
        desc = 'Add a surrounding pair around a motion (normal mode)',
        'ys',
      },
      {
        desc = 'Add a surrounding pair around the current line (normal mode)',
        'yss',
      },
      {
        desc = 'Add a surrounding pair around a motion, on new lines (normal mode)',
        'yS',
      },
      {
        desc = 'Add a surrounding pair around the current line, on new lines (normal mode)',
        'ySS',
      },
      {
        desc = 'Add a surrounding pair around a visual selection',
        mode = 'x',
        'S',
      },
      {
        desc = 'Add a surrounding pair around a visual selection, on new lines',
        mode = 'x',
        'gS',
      },
      {
        desc = 'Delete a surrounding pair',
        'ds',
      },
      {
        desc = 'Change a surrounding pair',
        'cs',
      },
      {
        desc = 'Change a surrounding pair, putting replacements on new lines',
        'cS',
      },
    },
    opts = {},
  },
  {
    'folke/ts-comments.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'rlane/pounce.nvim',
    keys = {
      {
        desc = 'Jump',
        mode = { 'n', 'x', 'o' },
        '<leader><leader>',
        '<Cmd>Pounce<CR>',
      },
      {
        desc = 'Repeat Jump',
        mode = { 'n', 'x', 'o' },
        '<leader><leader><leader>',
        '<Cmd>PounceRepeat<CR>',
      },
    },
  },
  {
    'brenoprata10/nvim-highlight-colors',
    event = { 'BufReadPre', 'BufNew', 'BufNewFile' },
    cmd = { 'HighlightColors' },
    opts = {
      enable_tailwind = true,
    },
  },
}
