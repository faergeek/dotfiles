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
          winbar = { 'alpha' },
        },
        globalstatus = true,
        theme = 'catppuccin',
      },
      sections = {
        lualine_a = {
          'mode',
          'selectioncount',
        },
        lualine_b = {
          { 'b:gitsigns_head', icon = '' },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'searchcount' },
      },
      winbar = {
        lualine_a = {
          { 'filetype', colored = false, icon_only = true },
          { 'filename', newfile_status = true, path = 1 },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_winbar = {
        lualine_a = {
          { 'filetype', colored = false, icon_only = true },
          { 'filename', newfile_status = true, path = 1 },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      extensions = {
        {
          filetypes = { 'buffer_manager' },
          sections = {
            lualine_a = {
              'mode',
              'selectioncount',
            },
            lualine_b = {
              function() return 'Buffer Manager' end,
            },
            lualine_z = { 'searchcount' },
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
                local ok, oil = pcall(require, 'oil')
                if ok then
                  return vim.fn.fnamemodify(oil.get_current_dir(), ':p:~:.')
                else
                  return ''
                end
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
            lualine_b = {
              'w:quickfix_title',
            },
            lualine_z = { 'location' },
          },
        },
      },
    },
  },
}
