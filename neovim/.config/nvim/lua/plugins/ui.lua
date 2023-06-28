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
        desc = '[T]rouble: [T]oggle',
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
        desc = '[F]ind [R]eferences',
        '<leader>fr',
        ':Trouble lsp_references<CR>',
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
