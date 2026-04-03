---@type vim.lsp.Config
return {
  ---@module 'lspconfig'
  ---@type lspconfig.settings.tailwindcss
  settings = {
    tailwindCSS = {
      classFunctions = { 'clsx', 'cn', 'classNames', 'cva' },
    },
  },
}
