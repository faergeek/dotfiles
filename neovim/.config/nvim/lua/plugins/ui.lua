return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      require('which-key').setup(opts)
      vim.opt.timeoutlen = 600
    end,
  },
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { desc = 'Oil', '-', ':Oil<CR>', silent = true },
    },
    opts = {
      default_file_explorer = false,
      keymaps = {
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['q'] = 'actions.close',
        ['='] = 'actions.refresh',
        ['-'] = 'actions.parent',
      },
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
        desc = 'Buffer Manager: [O]pen buffers',
        '<leader>o',
        function() require('buffer_manager.ui').toggle_quick_menu() end,
      },
      {
        desc = '[B]uffer Manager: Next',
        ']b',
        function() require('buffer_manager.ui').nav_next() end,
      },
      {
        desc = '[B]uffer Manager: Prev',
        '[b',
        function() require('buffer_manager.ui').nav_prev() end,
      },
    },
    opts = {
      focus_alternate_buffer = true,
      short_term_names = true,
    },
  },
}
