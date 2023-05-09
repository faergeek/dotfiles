return {
  { 'folke/which-key.nvim', event = 'VeryLazy', opts = {} },
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    keys = {
      { desc = 'Oil', '-', ':Oil<CR>', silent = true },
    },
    opts = {
      keymaps = {
        ['?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['<C-v>'] = 'actions.select_vsplit',
        ['<C-x>'] = 'actions.select_split',
        ['<C-p>'] = 'actions.preview',
        ['q'] = 'actions.close',
        ['<C-l>'] = 'actions.refresh',
        ['-'] = 'actions.parent',
        ['~'] = 'actions.open_cwd',
        ['g.'] = 'actions.toggle_hidden',
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
    },
    opts = {
      focus_alternate_buffer = true,
      short_term_names = true,
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {
        desc = '[T]rouble: Open',
        '<leader>tt',
        ':TroubleToggle<CR>',
        silent = true,
      },
      {
        desc = '[T]rouble: Workspace [D]iagnostics',
        '<leader>td',
        ':Trouble workspace_diagnostics<CR>',
        silent = true,
      },
      {
        desc = '[T]rouble: [Q]uickfix',
        '<leader>tq',
        ':cclose<CR>:Trouble quickfix<CR>',
        silent = true,
      },
      {
        desc = '[T]rouble: [L]ocation List',
        '<leader>tl',
        ':lclose<CR>:Trouble loclist<CR>',
        silent = true,
      },
    },
    opts = {
      use_diagnostic_signs = true,
    },
  },
}
