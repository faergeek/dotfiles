return {
  settings = {
    javascript = {
      preferences = {
        jsxAttributeCompletionStyle = 'braces',
      },
      tsserver = {
        maxTsServerMemory = 8 * 1024,
      },
      updateImportsOnFileMove = 'always',
    },
    typescript = {
      preferences = {
        jsxAttributeCompletionStyle = 'braces',
      },
      tsserver = {
        maxTsServerMemory = 8 * 1024,
      },
      updateImportsOnFileMove = 'always',
    },
    vtsls = {
      autoUseWorkspaceTsdk = true,
      enableMoveToFileCodeAction = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
  },
}
