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
    lazy = false,
    keys = {
      { desc = 'Oil', '-', ':Oil<CR>', silent = true },
    },
    opts = {
      keymaps = {
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['<C-v>'] = 'actions.select_vsplit',
        ['<C-x>'] = 'actions.select_split',
        ['q'] = 'actions.close',
        ['<C-l>'] = 'actions.refresh',
        ['-'] = 'actions.parent',
        ['~'] = 'actions.open_cwd',
      },
      use_default_keymaps = false,
      view_options = {
        show_hidden = true,
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      {
        desc = '[B]ufferline: [P]ick',
        '<leader>bp',
        ':BufferLinePick<CR>',
        silent = true,
      },
      {
        desc = '[B]ufferline: Pick [C]lose',
        '<leader>bc',
        ':BufferLinePickClose<CR>',
        silent = true,
      },
    },
    opts = function()
      return {
        highlights = require('catppuccin.groups.integrations.bufferline').get {
          styles = { 'bold' },
        },
        options = {
          separator_style = 'thin',
        },
      }
    end,
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
