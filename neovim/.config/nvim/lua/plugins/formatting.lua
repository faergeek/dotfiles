return {
  {
    'faergeek/format-on-save.nvim',
    event = 'BufWritePre',
    cmd = {
      'Format',
      'FormatDebugOff',
      'FormatDebugOn',
      'FormatOff',
      'FormatOn',
    },
    opts = function()
      local formatters = require 'format-on-save.formatters'

      local eslint = formatters.lsp { client_name = 'eslint' }

      local function expand_node_bin(bin, ...)
        local relative_path =
          vim.fs.normalize('node_modules/.bin/' .. bin, { expand_env = false })

        local results = vim.fs.find(relative_path, {
          path = vim.fn.expand '%:p:h',
          type = 'file',
          upward = true,
        })

        local node_bin_path = results[1]

        if node_bin_path then
          return {
            mode = 'shell',
            expand_executable = false,
            cmd = { node_bin_path, ... },
          }
        end
      end

      local function prettier()
        return expand_node_bin('prettier', '--stdin-filepath', '%')
          or formatters.if_file_exists {
            pattern = { '.prettierrc', '.prettierrc.*', 'prettier.config.*' },
            formatter = formatters.shell {
              cmd = { 'prettier', '--stdin-filepath', '%' },
            },
          }
      end

      return {
        experiments = {
          adjust_cursor_position = true,
          disable_restore_cursors = true,
          partial_update = 'diff',
        },
        fallback_formatter = {
          formatters.lsp {},
        },
        formatter_by_ft = {
          css = { prettier },
          dune = { formatters.shell { cmd = { 'dune', 'format-dune-file' } } },
          fish = { formatters.shell { cmd = { 'fish_indent' } } },
          html = { prettier },
          javascript = { eslint, prettier },
          javascriptreact = { eslint, prettier },
          json = { prettier },
          jsonc = { prettier },
          lua = { formatters.stylua },
          markdown = { prettier },
          sql = {
            formatters.shell {
              cmd = { 'sql-formatter', '--language', 'postgresql' },
            },
          },
          typescript = { eslint, prettier },
          typescriptreact = { eslint, prettier },
          yaml = { prettier },
        },
      }
    end,
  },
}
