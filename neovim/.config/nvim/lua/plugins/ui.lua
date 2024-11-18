return {
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
      {
        desc = 'Next buffer',
        ']b',
        function() require('buffer_manager.ui').nav_next() end,
      },
      {
        desc = 'Previous buffer',
        '[b',
        function() require('buffer_manager.ui').nav_prev() end,
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
