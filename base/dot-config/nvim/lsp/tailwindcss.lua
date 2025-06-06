return {
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          {
            '(?:clsx|cn|cva|cx)\\(([^()]*(?:\\([^)]*\\)[^()]*)*)\\)',
            '["\'`]([^"\'`]*)["\'`]',
          },
          {
            '(?:~className:\\s*)"([^"]*(?:\\([^"]*\\)[^"]*)*)"',
            '([^"]*)',
          },
          {
            '(?:~className:\\s*)\\(([^()]*(?:\\([^)]*\\)[^()]*)*)\\)',
            '"([^"]*)"',
          },
        },
      },
    },
  },
}
