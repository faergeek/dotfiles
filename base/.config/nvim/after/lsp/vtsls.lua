---@type vim.lsp.Config
return {
  ---@module 'lspconfig'
  ---@type lspconfig.settings.vtsls
  settings = {
    javascript = {
      suggestionActions = { enabled = false },
      updateImportsOnFileMove = { enabled = 'always' },
    },
    typescript = {
      disableAutomaticTypeAcquisition = true,
      suggestionActions = { enabled = false },
      updateImportsOnFileMove = { enabled = 'always' },
    },
    vtsls = {
      autoUseWorkspaceTsdk = true,
    },
  },
}
