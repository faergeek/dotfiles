return {
  {
    'nvim-treesitter/nvim-treesitter',
    main = 'nvim-treesitter.configs',
    dependencies = {
      'windwp/nvim-ts-autotag',
      'RRethy/nvim-treesitter-endwise',
      'andymass/vim-matchup',
      'HiPhish/nvim-ts-rainbow2',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    build = function()
      local ts_update =
        require('nvim-treesitter.install').update { with_sync = true }
      ts_update()
    end,
    opts = {
      auto_install = true,
      autotag = { enable = true },
      endwise = { enable = true },
      highlight = {
        additional_vim_regex_highlighting = false,
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_decremental = '<c-backspace>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
        },
      },
      indent = { enable = true },
      matchup = {
        enable = true,
        include_match_words = false,
      },
      rainbow = { enable = true },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
  {
    'windwp/nvim-autopairs',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'InsertEnter',
    opts = {
      check_ts = true,
      disable_filetype = { 'lisp', 'spectre_panel', 'TelescopePrompt' },
    },
  },
  { 'nmac427/guess-indent.nvim', event = 'BufReadPre', opts = {} },
  { 'gpanders/nvim-parinfer', ft = 'lisp' },
  { 'Olical/conjure', ft = 'lisp' },
  {
    'echasnovski/mini.surround',
    main = 'mini.surround',
    keys = { { 'sa', mode = { 'n', 'v' } }, 'sd', 'sr', 'sf', 'sF', 'sh', 'sn' },
    opts = {},
  },
  {
    'echasnovski/mini.ai',
    main = 'mini.ai',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    opts = function()
      local ai = require 'mini.ai'

      return {
        n_lines = 500,
        custom_textobjects = {
          b = ai.gen_spec.treesitter({
            a = '@block.outer',
            i = '@block.inner',
          }, {}),
          f = ai.gen_spec.treesitter(
            { a = '@function.outer', i = '@function.inner' },
            {}
          ),
        },
      }
    end,
  },
  {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    keys = {
      'gcc',
      'gbc',
      { 'gc', mode = { 'n', 'v' } },
      { 'gb', mode = { 'n', 'v' } },
      'gcO',
      'gco',
      'gcA',
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
    'NvChad/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      user_default_options = {
        css = true,
        RRGGBBAA = true,
        AARRGGBB = true,
      },
    },
  },
}
