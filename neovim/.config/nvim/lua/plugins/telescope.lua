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
      'folke/trouble.nvim',
      'rcarriga/nvim-notify',
    },
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
        desc = '[F]ind [N]otification',
        '<leader>fn',
        ':Telescope notify<CR>',
        silent = true,
      },
      {
        desc = '[F]ind [S]ymbols',
        '<leader>fs',
        ':Telescope lsp_dynamic_workspace_symbols<CR>',
        silent = true,
      },
      {
        desc = '[F]ind [R]eferences',
        '<leader>fr',
        ':Telescope lsp_references<CR>',
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
        desc = '[G]it [S]tatus',
        '<leader>gs',
        ':Telescope git_status<CR>',
        silent = true,
      },
      {
        desc = '[G]it [C]ommits',
        '<leader>gc',
        ':Telescope git_commits<CR>',
        silent = true,
      },
    },
    opts = function()
      return {
        defaults = require('telescope.themes').get_ivy {
          dynamic_preview_title = true,
          file_ignore_patterns = { '^.git/' },
          layout_config = {
            width = 0.95,
            height = 0.95,
            horizontal = { preview_width = 0.6 },
          },
          mappings = {
            i = {
              ['<c-t>'] = require('trouble.providers.telescope').smart_open_with_trouble,
            },
            n = {
              ['<c-t>'] = require('trouble.providers.telescope').smart_open_with_trouble,
            },
          },
          path_display = { shorten = 5 },
        },
        pickers = {
          find_files = { hidden = true, no_ignore = true },
          live_grep = { additional_args = { '--hidden' } },
          oldfiles = { only_cwd = true },
        },
      }
    end,
    config = function(_, opts)
      require('telescope').setup(opts)
      pcall(require('telescope').load_extension, 'fzf')
      require('telescope').load_extension 'notify'
    end,
  },
}
