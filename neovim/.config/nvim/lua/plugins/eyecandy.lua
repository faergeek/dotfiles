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
        alpha = true,
        cmp = true,
        dap = {
          enabled = true,
          enable_ui = true,
        },
        gitsigns = true,
        lsp_trouble = true,
        markdown = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
          },
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        telescope = true,
        treesitter = true,
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
