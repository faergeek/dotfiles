return {
  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      flavour = 'frappe',
      integrations = {
        blink_cmp = true,
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
        pounce = true,
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
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    keys = {
      { desc = 'Oil', '-', '<Cmd>Oil<CR>' },
    },
    opts = {
      keymaps = {
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['q'] = 'actions.close',
        ['='] = 'actions.refresh',
        ['-'] = 'actions.parent',
        ['gx'] = 'actions.open_external',
      },
      lsp_file_methods = {
        autosave_changes = true,
        timeout_ms = 10000,
      },
      skip_confirm_for_simple_edits = true,
      use_default_keymaps = false,
      view_options = {
        show_hidden = true,
      },
    },
  },
  {
    'j-morano/buffer_manager.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {
        desc = 'Buffer Manager',
        '<leader>o',
        function() require('buffer_manager.ui').toggle_quick_menu() end,
      },
    },
    opts = {
      line_keys = '',
      show_indicators = 'after',
      width = 0.9,
    },
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    opts = {
      auto_resize_height = true,
      preview = {
        wrap = true,
      },
    },
  },
}
