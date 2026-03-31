return {
  { 'nvim-mini/mini.icons', opts = {} },
  {
    'tpope/vim-dispatch',
    cmd = {
      'AbortDispatch',
      'Copen',
      'Dispatch',
      'FocusDispatch',
      'Make',
      'Spawn',
      'Start',
    },
    keys = {
      'm<CR>',
      'm<Space>',
      'm!',
      'm?',
      '`<CR>',
      '`<Space>',
      '`!',
      '`?',
      "'<CR>",
      "'<Space>",
      "'!",
      "'?",
      "g'<CR>",
      "g'<Space>",
      "g'!",
      "g'?",
    },
  },
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    keys = {
      {
        desc = 'Session: Restore',
        '<leader>sr',
        function() require('persistence').load() end,
      },
    },
  },
  {
    'folke/snacks.nvim',
    dependencies = 'nvim-mini/mini.icons',
    priority = 1000,
    lazy = false,
    keys = {
      {
        desc = 'Find Builtin',
        '<leader>fb',
        function() Snacks.picker() end,
      },
      {
        desc = 'Find Buffers',
        '<leader>o',
        function()
          Snacks.picker.buffers {
            layout = {
              layout = { position = 'bottom' },
              preset = 'ivy',
              preview = 'main',
            },
          }
        end,
      },
      {
        desc = 'Find Old files',
        '<leader>fo',
        function()
          Snacks.picker.recent {
            filter = { cwd = true },
            layout = {
              layout = { position = 'bottom' },
              preset = 'ivy',
              preview = 'main',
            },
          }
        end,
      },
      {
        desc = 'Find Files',
        '<leader>ff',
        function()
          Snacks.picker.files {
            cmd = 'rg',
            layout = {
              layout = { position = 'bottom' },
              preset = 'ivy',
              preview = 'main',
            },
          }
        end,
      },
      {
        desc = 'Find with Grep',
        '<leader>fg',
        function()
          Snacks.picker.grep {
            hidden = true,
            layout = {
              layout = { position = 'bottom' },
              preset = 'ivy',
              preview = 'main',
            },
          }
        end,
      },
      {
        desc = 'Find Symbols',
        '<leader>fs',
        function()
          Snacks.picker.lsp_workspace_symbols {
            layout = {
              layout = { position = 'bottom' },
              preset = 'ivy',
              preview = 'main',
            },
          }
        end,
      },
      {
        desc = 'Find Help',
        '<leader>fh',
        function()
          Snacks.picker.help {
            layout = {
              layout = { position = 'bottom' },
              preset = 'ivy',
            },
          }
        end,
      },
      {
        desc = 'Find Man Pages',
        '<leader>fm',
        function()
          Snacks.picker.man {
            layout = {
              layout = { position = 'bottom' },
              preset = 'ivy',
            },
          }
        end,
      },
      {
        desc = 'Find Commands',
        '<leader>fc',
        function() Snacks.picker.commands() end,
      },
      {
        desc = 'Find Keymaps',
        '<leader>fk',
        function() Snacks.picker.keymaps() end,
      },
    },
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      bigfile = { notify = false },
      image = {
        convert = { notify = false },
        doc = { enabled = false },
      },
      picker = {
        formatters = {
          file = { filename_first = true, truncate = 200 },
        },
      },
      quickfile = {},
    },
  },
}
