return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = function()
      local opts = {
        extensions = { 'lazy', 'man', 'quickfix' },
        options = {
          disabled_filetypes = {
            statusline = { 'alpha', 'buffer_manager' },
            winbar = { 'alpha', 'man', 'qf' },
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
          lualine_c = {
            { 'filename', newfile_status = true, path = 1 },
          },
          lualine_x = { '%S' },
          lualine_y = {},
          lualine_z = { 'searchcount' },
        },
        winbar = {
          lualine_a = {
            function() return tostring(vim.api.nvim_win_get_number(0)) end,
            { 'filename', newfile_status = true },
          },
          lualine_b = { 'location' },
          lualine_y = {
            {
              'diff',
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
          },
          lualine_z = { 'progress' },
        },
      }

      opts.inactive_winbar = opts.winbar

      return opts
    end,
  },
}
