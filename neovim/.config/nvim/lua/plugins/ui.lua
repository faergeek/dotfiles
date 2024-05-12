return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
      {
        -- See: https://github.com/folke/which-key.nvim/issues/476
        desc = 'Workaround for which-key not showing up on <localleader>',
        '<localleader>',
        function() require('which-key').show(vim.g.maplocalleader) end,
      },
    },
    opts = {},
    init = function() vim.opt.timeoutlen = 300 end,
  },
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    keys = {
      { desc = 'Oil', '-', '<Cmd>Oil<CR>', silent = true },
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
