return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'natecraddock/telescope-zf-native.nvim', lazy = true },
    },
    cmd = 'Telescope',
    keys = {
      {
        desc = 'Find Builtin',
        '<leader>fb',
        '<Cmd>Telescope builtin<CR>',
      },
      {
        desc = 'Find Old files',
        '<leader>fo',
        '<Cmd>Telescope oldfiles<CR>',
      },
      {
        desc = 'Find Files',
        '<leader>ff',
        '<Cmd>Telescope find_files<CR>',
      },
      {
        desc = 'Find with Grep',
        '<leader>fg',
        '<Cmd>Telescope live_grep<CR>',
      },
      {
        desc = 'Find Symbols',
        '<leader>fs',
        '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>',
      },
      {
        desc = 'Find Help',
        '<leader>fh',
        '<Cmd>Telescope help_tags<CR>',
      },
      {
        desc = 'Find Man Pages',
        '<leader>fm',
        '<Cmd>Telescope man_pages<CR>',
      },
      {
        desc = 'Find Commands',
        '<leader>fc',
        '<Cmd>Telescope commands<CR>',
      },
      {
        desc = 'Find Keymaps',
        '<leader>fk',
        '<Cmd>Telescope keymaps<CR>',
      },
      {
        desc = 'Find fileTypes',
        '<leader>ft',
        '<Cmd>Telescope filetypes<CR>',
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
              '--no-ignore-vcs',
            },
          },
          live_grep = {
            additional_args = { '--hidden', '--no-ignore-vcs' },
          },
          oldfiles = { only_cwd = true },
        },
      }
    end,
    config = function(_, opts)
      require('telescope').setup(opts)
      pcall(require('telescope').load_extension, 'zf-native')
    end,
  },
}
