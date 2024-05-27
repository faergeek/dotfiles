return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
    },
    cmd = 'Telescope',
    keys = {
      {
        desc = 'Find Builtin',
        '<leader>fb',
        '<Cmd>Telescope builtin<CR>',
        silent = true,
      },
      {
        desc = 'Find Old files',
        '<leader>fo',
        '<Cmd>Telescope oldfiles<CR>',
        silent = true,
      },
      {
        desc = 'Find Files',
        '<leader>ff',
        '<Cmd>Telescope find_files<CR>',
        silent = true,
      },
      {
        desc = 'Find with Grep',
        '<leader>fg',
        '<Cmd>Telescope live_grep<CR>',
        silent = true,
      },
      {
        desc = 'Find Symbols',
        '<leader>fs',
        '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>',
        silent = true,
      },
      {
        desc = 'Find Help',
        '<leader>fh',
        '<Cmd>Telescope help_tags<CR>',
        silent = true,
      },
      {
        desc = 'Find Commands',
        '<leader>fc',
        '<Cmd>Telescope commands<CR>',
        silent = true,
      },
      {
        desc = 'Find Keymaps',
        '<leader>fk',
        '<Cmd>Telescope keymaps<CR>',
        silent = true,
      },
    },
    opts = function()
      return {
        defaults = require('telescope.themes').get_ivy {
          dynamic_preview_title = true,
          path_display = { 'filename_first' },
        },
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
      pcall(require('telescope').load_extension, 'fzy_native')
    end,
  },
}
