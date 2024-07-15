return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'arkav/lualine-lsp-progress',
    },
    opts = function()
      local function winnr() return '󰕰 ' .. vim.fn.winnr() end
      local function bufnr() return '󱔗 ' .. vim.fn.bufnr() end

      local function lualine_c(filename_opts)
        filename_opts = filename_opts or {}

        return {
          {
            'filetype',
            icon_only = true,
            separator = '',
            padding = { left = 1, right = 0 },
          },
          {
            'filename',
            file_status = filename_opts.file_status,
            padding = 0,
            path = filename_opts.fullpath and 1,
            separator = '',
          },
        }
      end

      local sections = {
        lualine_a = { winnr },
        lualine_b = { bufnr },
        lualine_c = lualine_c { fullpath = true },
        lualine_x = { 'searchcount' },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
      }

      return {
        options = {
          disabled_filetypes = { 'alpha', 'dbui', 'fugitiveblame' },
          theme = 'catppuccin',
        },
        tabline = {
          lualine_a = {
            'mode',
            'selectioncount',
            function() return vim.fn.fnamemodify(vim.fn.getcwd(), ':p:~:h') end,
          },
          lualine_b = {
            function()
              if package.loaded['dap'] then
                local dap_status = require('dap').status()

                return dap_status ~= '' and '󰃤 ' .. dap_status or ''
              else
                return ''
              end
            end,
          },
          lualine_x = { 'lsp_progress' },
          lualine_z = {
            {
              'tabs',
              show_modified_status = false,
              use_mode_colors = true,
            },
          },
        },
        sections = sections,
        inactive_sections = sections,
        extensions = {
          {
            filetypes = { 'fugitive', 'git' },
            sections = vim.tbl_extend('force', sections, {
              lualine_c = { { 'FugitiveHead', icon = '' } },
            }),
          },
          {
            filetypes = { 'help', 'man' },
            sections = vim.tbl_extend('force', sections, {
              lualine_c = lualine_c { file_status = false },
            }),
          },
          {
            filetypes = { 'oil' },
            sections = vim.tbl_extend('force', sections, {
              lualine_c = {
                {
                  function()
                    local dir = require('oil').get_current_dir()

                    return dir and vim.fn.fnamemodify(dir, ':p:~:.')
                  end,
                  icon = {
                    '',
                    color = {
                      fg = require('catppuccin.palettes').get_palette('frappe').blue,
                    },
                  },
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
