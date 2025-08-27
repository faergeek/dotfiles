return {
  {
    'nvim-tree/nvim-web-devicons',
    opts = {
      default = true,
    },
  },
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
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    keys = {
      {
        desc = 'Find Builtin',
        '<leader>fb',
        function() Snacks.picker() end,
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
              preview = 'main',
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
      dashboard = {
        preset = {
          header = [[
                                                                   
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████]],
          keys = {
            { icon = ' ', key = 'e', desc = 'New file', action = ':enew' },
            { icon = ' ', key = 'r', desc = 'Restore', section = 'session' },
            { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
            { icon = '󰾍 ', key = 'm', desc = 'Mason', action = ':Mason' },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':q' },
          },
        },
        sections = {
          { section = 'header' },
          { section = 'keys', padding = 1 },
          { section = 'startup', padding = 1 },
        },
      },
      image = {
        convert = { notify = false },
        doc = { inline = false },
      },
      picker = {
        formatters = {
          file = { filename_first = true },
        },
      },
      quickfile = {},
    },
  },
}
