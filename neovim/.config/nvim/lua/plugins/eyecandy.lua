return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      flavour = 'frappe',
      transparent_background = true,
      integrations = {
        fidget = true,
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        notify = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    opts = {
      text = {
        spinner = 'dots',
      },
      window = {
        blend = 0,
        relative = 'editor',
      },
    },
  },
  {
    'rcarriga/nvim-notify',
    opts = {
      background_colour = '#000000',
    },
    config = function(_, opts)
      local notify = require 'notify'
      notify.setup(opts)
      vim.notify = notify
    end,
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {
      input = {
        insert_only = false,
        start_in_insert = false,
        win_options = { winblend = 0 },
      },
    },
  },
}
