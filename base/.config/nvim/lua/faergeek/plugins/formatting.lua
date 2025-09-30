return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    opts = function()
      ---@type conform.FiletypeFormatterInternal
      local eslint_then_prettier = {
        lsp_format = 'first',
        name = 'eslint',
        'prettier',
      }

      ---@type conform.setupOpts
      return {
        formatters = {
          meson = {
            command = 'meson',
            args = { 'format', '--source-file-path', '$FILENAME', '-' },
          },
          prettier = {
            require_cwd = true,
          },
        },
        formatters_by_ft = {
          _ = { lsp_format = 'fallback' },
          c = { 'clang-format' },
          cpp = { 'clang-format' },
          css = { 'prettier' },
          dockerfile = { lsp_format = 'never' },
          dune = { 'format-dune-file' },
          fish = { 'fish_indent' },
          html = { 'prettier' },
          javascript = eslint_then_prettier,
          javascriptreact = eslint_then_prettier,
          json = { 'prettier' },
          jsonc = { 'prettier' },
          less = { 'prettier' },
          lua = { 'stylua' },
          markdown = { 'prettier' },
          meson = { 'meson' },
          sh = { 'shfmt' },
          sql = { 'sql_formatter' },
          typescript = eslint_then_prettier,
          typescriptreact = eslint_then_prettier,
          yaml = { 'prettier' },
        },
        format_on_save = function(bufnr)
          if vim.b[bufnr].no_format_on_save then return end

          return {}
        end,
      }
    end,
    init = function()
      vim.api.nvim_create_user_command(
        'Format',
        function() require('conform').format() end,
        {}
      )

      vim.api.nvim_create_user_command(
        'FormatOff',
        function() vim.b.no_format_on_save = true end,
        {}
      )

      vim.api.nvim_create_user_command(
        'FormatOn',
        function() vim.b.no_format_on_save = nil end,
        {}
      )
    end,
  },
}
