return {
  {
    'elentok/format-on-save.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
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
      end

      local function list(...)
        local items = { ... }

        return function()
          local result = {}

          for _, item in ipairs(items) do
            if type(item) == 'function' then item = item() end

            table.insert(result, item)
          end

          return result
        end
      end

      return {
        fallback_formatter = {
          formatters.lsp {},
        },
        formatter_by_ft = {
          css = list(prettier),
          dune = { formatters.shell { cmd = { 'dune', 'format-dune-file' } } },
          html = list(prettier),
          javascript = list(eslint, prettier),
          javascriptreact = list(eslint, prettier),
          json = list(prettier),
          jsonc = list(prettier),
          lua = { formatters.stylua },
          markdown = list(prettier),
          typescript = list(eslint, prettier),
          typescriptreact = list(eslint, prettier),
          yaml = list(prettier),
        },
      }
    end,
  },
}
