return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        cond = vim.fn.executable 'make' == 1,
        build = 'make',
      },
    },
    cmd = 'Telescope',
    keys = {
      {
        desc = '[F]ind [B]uiltin',
        '<leader>fb',
        '<Cmd>Telescope builtin<CR>',
        silent = true,
      },
      {
        desc = '[F]ind [O]ld files',
        '<leader>fo',
        '<Cmd>Telescope oldfiles<CR>',
        silent = true,
      },
      {
        desc = '[F]ind [F]iles',
        '<leader>ff',
        '<Cmd>Telescope find_files<CR>',
        silent = true,
      },
      {
        desc = '[F]ind with [G]rep',
        '<leader>fg',
        '<Cmd>Telescope live_grep<CR>',
        silent = true,
      },
      {
        desc = '[F]ind [S]ymbols',
        '<leader>fs',
        '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>',
        silent = true,
      },
      {
        desc = '[F]ind [H]elp',
        '<leader>fh',
        '<Cmd>Telescope help_tags<CR>',
        silent = true,
      },
      {
        desc = '[F]ind [C]ommands',
        '<leader>fc',
        '<Cmd>Telescope commands<CR>',
        silent = true,
      },
      {
        desc = '[F]ind [K]eymaps',
        '<leader>fk',
        '<Cmd>Telescope keymaps<CR>',
        silent = true,
      },
    },
    opts = function()
      return {
        defaults = require('telescope.themes').get_ivy(),
        pickers = {
          find_files = {
            find_command = {
              'fd',
              '--type',
              'f',
              '--hidden',
              '--no-ignore',
              '--exclude',
              'node_modules',
              '--exclude',
              '.git',
            },
          },
          live_grep = {
            additional_args = { '--hidden', '--no-ignore' },
            glob_pattern = { '!**/node_modules/**', '!**/.git/**' },
          },
          oldfiles = { only_cwd = true },
        },
      }
    end,
    config = function(_, opts)
      require('telescope').setup(opts)
      pcall(require('telescope').load_extension, 'fzf')
    end,
  },
}
