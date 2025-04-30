return {
  settings = {
    javascript = {
      preferences = {
        jsxAttributeCompletionStyle = 'braces',
      },
      tsserver = {
        maxTsServerMemory = 8 * 1024,
      },
    },
    typescript = {
      preferences = {
        jsxAttributeCompletionStyle = 'braces',
      },
      tsserver = {
        maxTsServerMemory = 8 * 1024,
      },
    },
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
  },
}
