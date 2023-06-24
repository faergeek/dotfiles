return {
  {
    'nvim-treesitter/nvim-treesitter',
    main = 'nvim-treesitter.configs',
    dependencies = {
      'windwp/nvim-ts-autotag',
      'RRethy/nvim-treesitter-endwise',
      'andymass/vim-matchup',
      'HiPhish/nvim-ts-rainbow2',
      'nvim-treesitter/playground',
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
    opts = {
      enable = false,
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
    config = function(_, opts)
      local autopairs = require 'nvim-autopairs'
      autopairs.setup(opts)

      local function disable_rule_for_ft(rule, ft)
        if not rule.not_filetypes then rule.not_filetypes = {} end

        table.insert(rule.not_filetypes, ft)
      end

      disable_rule_for_ft(autopairs.get_rules("'")[1], 'lisp')
      disable_rule_for_ft(autopairs.get_rules('`')[1], 'lisp')

      autopairs.force_attach()
    end,
  },
  { 'nmac427/guess-indent.nvim', event = 'BufReadPre', opts = {} },
  { 'gpanders/nvim-parinfer', ft = 'lisp' },
  { 'Olical/conjure', ft = 'lisp' },
  {
    'echasnovski/mini.surround',
    keys = { { 'sa', mode = { 'n', 'v' } }, 'sd', 'sr', 'sf', 'sF', 'sh', 'sn' },
    opts = {},
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
