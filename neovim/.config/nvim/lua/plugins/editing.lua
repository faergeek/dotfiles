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
    build = ':TSUpdate',
    opts = {
      auto_install = true,
      endwise = { enable = true },
      ensure_installed = {
        'c',
        'diff',
        'git_rebase',
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
    opts = {
      providers = {
        'lsp',
        'treesitter',
      },
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
      { desc = 'Comment toggle linewise (visual)', 'gc', mode = { 'x' } },
      { desc = 'Comment toggle current block', 'gbc' },
      { desc = 'Comment toggle blockwise (visual)', 'gb', mode = { 'x' } },
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
        mode = { 'n', 'x' },
        '<leader><leader>',
        '<Cmd>Pounce<CR>',
      },
      {
        desc = 'Repeat Jump',
        mode = { 'n', 'x' },
        '<leader><leader><leader>',
        '<Cmd>PounceRepeat<CR>',
      },
    },
  },
  {
    'brenoprata10/nvim-highlight-colors',
    event = { 'BufReadPre', 'BufNew', 'BufNewFile' },
    cmd = { 'HighlightColors' },
    opts = {},
  },
}
