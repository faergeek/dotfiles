return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      flavour = 'frappe',
      integrations = {
        fidget = true,
        mason = true,
        native_lsp = {
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        nvim_surround = true,
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
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {
      input = {
        start_in_insert = false,
      },
      select = {
        get_config = function(opts)
          if opts.kind == 'codeaction' then
            return {
              backend = 'telescope',
              telescope = require('telescope.themes').get_cursor {},
            }
          end
        end,
      },
    },
  },
}
