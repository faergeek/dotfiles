---@type vim.lsp.Config
return {
  ---@module 'lspconfig'
  ---@type lspconfig.settings.tailwindcss
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          {
            '(?:clsx|cn|classNames|cva)\\(([^()]*(?:\\([^)]*\\)[^()]*)*)\\)',
            '["\'`]([^"\'`]*)["\'`]',
          },
        },
      },
    },
  },
}
