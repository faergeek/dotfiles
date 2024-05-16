return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
      local function winnr() return '󰕰 ' .. vim.fn.winnr() end
      local function bufnr() return '󱔗 ' .. vim.fn.bufnr() end

      local sections = {
        lualine_a = { winnr },
        lualine_b = { bufnr },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      }

      return {
        options = {
          disabled_filetypes = { 'dbui', 'fugitiveblame' },
          theme = 'catppuccin',
        },
        tabline = {
          lualine_a = {
            'mode',
            'selectioncount',
            function() return vim.fn.fnamemodify(vim.fn.getcwd(), ':p:~:h') end,
            { 'branch', icon = '' },
          },
          lualine_b = {
            {
              'tabs',
              show_modified_status = false,
              use_mode_colors = true,
            },
          },
          lualine_y = {
            function()
              local dap_status = require('dap').status()

              return dap_status ~= '' and '󰃤 ' .. dap_status or ''
            end,
          },
          lualine_z = { 'searchcount' },
        },
        sections = sections,
        inactive_sections = sections,
        extensions = {
          {
            filetypes = { 'fugitive', 'fugitiveblame', 'git' },
            sections = {
              lualine_a = { winnr },
              lualine_b = { bufnr },
              lualine_c = {},
              lualine_x = { 'filetype' },
              lualine_y = { 'progress' },
              lualine_z = { 'location' },
            },
          },
          {
            filetypes = { 'help', 'man' },
            sections = {
              lualine_a = { winnr },
              lualine_b = { bufnr },
              lualine_c = { { 'filename', file_status = false } },
              lualine_x = { 'filetype' },
              lualine_y = { 'progress' },
              lualine_z = { 'location' },
            },
          },
          {
            filetypes = { 'oil' },
            sections = {
              lualine_a = { winnr },
              lualine_b = { bufnr },
              lualine_c = {
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
              lualine_x = { 'filetype' },
              lualine_y = { 'progress' },
              lualine_z = { 'location' },
            },
          },
          {
            filetypes = { 'qf' },
            sections = {
              lualine_a = {
                function()
                  return vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0
                      and 'Location List'
                    or 'Quickfix List'
                end,
              },
              lualine_b = { 'w:quickfix_title' },
              lualine_x = { 'filetype' },
              lualine_y = { 'progress' },
              lualine_z = { 'location' },
            },
          },
        },
      }
    end,
  },
}
