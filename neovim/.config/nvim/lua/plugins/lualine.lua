return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'alpha' },
          winbar = { 'alpha', 'dbui' },
        },
        globalstatus = true,
        theme = 'catppuccin',
      },
      sections = {
        lualine_a = { 'mode', 'selectioncount' },
        lualine_b = {
          {
            'tabs',
            show_modified_status = false,
            use_mode_colors = true,
          },
        },
        lualine_c = {
          {
            'filename',
            cond = function()
              return not vim.tbl_contains({
                'buffer_manager',
                'dbui',
                'fugitive',
                'git',
                'help',
                'lazy',
                'man',
                'mason',
                'oil',
                'qf',
                'TelescopePrompt',
              }, vim.opt.filetype:get())
            end,
            newfile_status = true,
            path = 1,
          },
          {
            function()
              return vim.fn.fnamemodify(
                require('oil').get_current_dir(),
                ':p:~:.'
              )
            end,
            cond = function()
              return vim.tbl_contains({ 'oil' }, vim.opt.filetype:get())
            end,
          },
        },
        lualine_x = {},
        lualine_y = {
          function()
            local dap_status = require('dap').status()

            return dap_status ~= '' and '󰃤 ' .. dap_status or ''
          end,
        },
        lualine_z = { 'searchcount' },
      },
      winbar = {
        lualine_a = {
          { 'filetype', colored = false, icon_only = true },
          { 'filename', newfile_status = true },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_winbar = {
        lualine_a = {
          { 'filetype', colored = false, icon_only = true },
          { 'filename', newfile_status = true },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      extensions = {
        {
          filetypes = { 'fugitive', 'fugitiveblame', 'git' },
          winbar = {
            lualine_a = {
              function() return ' ' .. vim.fn.FugitiveHead() end,
            },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
          },
        },
        {
          filetypes = { 'help' },
          winbar = {
            lualine_a = {
              function() return '' end,
              function() return 'Help' end,
            },
            lualine_b = { { 'filename', file_status = false } },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
          },
        },
        {
          filetypes = { 'man' },
          winbar = {
            lualine_a = {
              { 'filetype', colored = false, icon_only = true },
              function() return 'Man' end,
            },
            lualine_b = { { 'filename', file_status = false } },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
          },
        },
        {
          filetypes = { 'oil' },
          winbar = {
            lualine_a = {
              function() return '' end,
              function()
                return vim.fn.fnamemodify(
                  require('oil').get_current_dir(),
                  ':p:~:h:t'
                )
              end,
            },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
          },
        },
        {
          filetypes = { 'qf' },
          winbar = {
            lualine_a = {
              function()
                return vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0
                    and 'Location List'
                  or 'Quickfix List'
              end,
            },
            lualine_b = { 'w:quickfix_title' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
          },
        },
      },
    },
  },
}
