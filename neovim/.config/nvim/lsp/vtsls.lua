return {
  settings = {
    javascript = {
      preferences = {
        jsxAttributeCompletionStyle = 'braces',
      },
      updateImportsOnFileMove = 'always',
    },
    typescript = {
      preferences = {
        jsxAttributeCompletionStyle = 'braces',
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
