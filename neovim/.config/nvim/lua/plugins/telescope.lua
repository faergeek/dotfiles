return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
    },
    cmd = 'Telescope',
    keys = {
      {
        desc = '[F]ind [B]uiltin',
        '<leader>fb',
        ':Telescope builtin<CR>',
        silent = true,
      },
      {
        desc = '[F]ind [O]ld files',
        '<leader>fo',
        ':Telescope oldfiles<CR>',
        silent = true,
      },
      {
        desc = '[F]ind [F]iles',
        '<leader>ff',
        ':Telescope find_files<CR>',
        silent = true,
      },
      {
        desc = '[F]ind with [G]rep',
        '<leader>fg',
        ':Telescope live_grep<CR>',
        silent = true,
      },
      {
        desc = '[F]ind [S]ymbols',
        '<leader>fs',
        ':Telescope lsp_dynamic_workspace_symbols<CR>',
        silent = true,
      },
      {
        desc = '[F]ind [H]elp',
        '<leader>fh',
        ':Telescope help_tags<CR>',
        silent = true,
      },
      {
        desc = '[F]ind [C]ommands',
        '<leader>fc',
        ':Telescope commands<CR>',
        silent = true,
      },
      {
        desc = '[F]ind [K]eymaps',
        '<leader>fk',
        ':Telescope keymaps<CR>',
        silent = true,
      },
      {
        desc = '[G]it: [S]tatus',
        '<leader>gs',
        ':Telescope git_status<CR>',
        silent = true,
      },
      {
        desc = '[G]it: [B]ranches',
        '<leader>gb',
        ':Telescope git_branches<CR>',
        silent = true,
      },
    },
    opts = function()
      return {
        defaults = require('telescope.themes').get_ivy(),
        pickers = {
          git_branches = {
            mappings = {
              i = {
                ['<CR>'] = require('telescope.actions').git_switch_branch,
              },
              n = {
                ['<CR>'] = require('telescope.actions').git_switch_branch,
              },
            },
          },
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
      require('telescope').load_extension 'fzy_native'
    end,
  },
}
