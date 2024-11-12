return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = function()
      local sections = {
        lualine_a = { function() return '󰕰 ' .. vim.fn.winnr() end },
        lualine_b = { function() return '󱔗 ' .. vim.fn.bufnr() end },
        lualine_c = { { 'filename', path = 1, shorting_target = 0 } },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      }

      return {
        options = {
          always_divide_middle = false,
          component_separators = { left = '', right = '' },
          disabled_filetypes = { 'dbui', 'fugitiveblame' },
          section_separators = { left = '', right = '' },
          theme = 'catppuccin',
        },
        tabline = {
          lualine_a = {
            { icon = '', 'mode' },
            'selectioncount',
            'branch',
          },
          lualine_b = {
            {
              'tabs',
              mode = 1,
              show_modified_status = false,
              use_mode_colors = true,
              fmt = function(_, context) return '󰓩 ' .. context.tabnr end,
            },
          },
          lualine_c = {
            {
              icon = '󰃤',
              function()
                return package.loaded['dap'] and require('dap').status() or ''
              end,
            },
          },
          lualine_x = {},
          lualine_y = { 'location' },
          lualine_z = { 'progress' },
        },
        sections = sections,
        inactive_sections = sections,
        extensions = {
          {
            filetypes = { 'alpha', 'fugitive', 'git' },
            sections = vim.tbl_extend('force', sections, { lualine_c = {} }),
          },
          {
            filetypes = { 'oil' },
            sections = vim.tbl_extend('force', sections, {
              lualine_c = {
                {
                  function()
                    return vim.fn.fnamemodify(
                      require('oil').get_current_dir() or '',
                      ':p:~:.:h'
                    )
                  end,
                },
              },
            }),
          },
          {
            filetypes = { 'qf' },
            sections = vim.tbl_extend('force', sections, {
              lualine_c = { 'w:quickfix_title' },
            }),
          },
        },
      }
    end,
  },
}
