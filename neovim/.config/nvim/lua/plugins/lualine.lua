return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function()
      local opts = {
        extensions = { 'lazy', 'man', 'nvim-dap-ui', 'quickfix', 'trouble' },
        options = {
          component_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = { 'alpha' },
            winbar = { 'alpha', 'dap-repl', 'man', 'qf' },
          },
          globalstatus = true,
          section_separators = { left = '', right = '' },
          theme = 'catppuccin',
        },
        sections = {
          lualine_a = {
            'mode',
            'selectioncount',
          },
          lualine_b = { { 'b:gitsigns_head', icon = '' } },
          lualine_c = {
            {
              'filename',
              newfile_status = true,
              path = 1,
              symbols = { modified = '' },
            },
          },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            {
              require('lazy.status').updates,
              cond = require('lazy.status').has_updates,
            },
          },
        },
        winbar = {
          lualine_a = {
            function() return tostring(vim.api.nvim_win_get_number(0)) end,
            {
              'filename',
              newfile_status = true,
              symbols = { modified = '' },
            },
          },
          lualine_x = {
            {
              'diff',
              symbols = {
                added = ' ',
                modified = '󰝤 ',
                removed = ' ',
              },
              source = function()
                local gitsigns =
                  vim.fn.getbufvar(vim.fn.bufnr(), 'gitsigns_status_dict')

                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
            'diagnostics',
            'encoding',
            'fileformat',
            'filetype',
          },
          lualine_y = { 'location' },
          lualine_z = { 'progress' },
        },
      }

      opts.inactive_winbar = opts.winbar

      return opts
    end,
  },
}
