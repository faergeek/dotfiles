return {
  {
    'elentok/format-on-save.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local formatters = require 'format-on-save.formatters'

      local eslint = formatters.lsp { client_name = 'eslint' }
      local prettier = formatters.prettierd

      return {
        formatter_by_ft = {
          css = { prettier },
          dune = { formatters.shell { cmd = { 'dune', 'format-dune-file' } } },
          html = { prettier },
          javascript = { eslint, prettier },
          javascriptreact = { eslint, prettier },
          json = { prettier },
          jsonc = { prettier },
          lua = { formatters.stylua },
          markdown = { prettier },
          typescript = { eslint, prettier },
          typescriptreact = { eslint, prettier },
          yaml = { prettier },
        },

        fallback_formatter = {
          formatters.lsp {},
        },
      }
    end,
  },
}
