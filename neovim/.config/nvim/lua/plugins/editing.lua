return {
  {
    'nvim-treesitter/nvim-treesitter',
    main = 'nvim-treesitter.configs',
    dependencies = {
      'windwp/nvim-ts-autotag',
      'RRethy/nvim-treesitter-endwise',
    },
    build = function()
      local ts_update =
        require('nvim-treesitter.install').update { with_sync = true }
      ts_update()
    end,
    opts = {
      auto_install = true,
      autotag = {
        enable = true,
        enable_close_on_slash = false,
      },
      endwise = { enable = true },
      ensure_installed = {
        'c',
        'jsdoc',
        'lua',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
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
  { 'nmac427/guess-indent.nvim', event = 'BufReadPre', opts = {} },
  { 'farmergreg/vim-lastplace', event = 'BufReadPre' },
  {
    'Wansmer/treesj',
    keys = {
      {
        desc = '[J]oin: Toggle',
        '<leader>j',
        '<Cmd>TSJToggle<CR>',
      },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
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
    opts = {
      user_default_options = {
        css = true,
        RRGGBBAA = true,
        AARRGGBB = true,
      },
    },
  },
  'HiPhish/rainbow-delimiters.nvim',
  {
    -- TODO: remove once nvim 0.10.0 is released
    -- https://github.com/neovim/neovim/issues/23231
    'chrishrb/gx.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      handler_options = {
        search_engine = 'duckduckgo',
      },
    },
  },
}
