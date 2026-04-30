vim.filetype.add {
  extension = {
    mli = 'ocamlinterface',
    mll = 'ocamllex',
    mly = 'ocamllex',
  },
  filename = {
    ['.eslintignore'] = 'gitignore',
    ['.swcrc'] = 'jsonc',
    ['Tiltfile'] = 'tiltfile',
  },
  pattern = {
    ['.*/%.config/fish/themes/.*%.theme'] = 'fish',
    ['.*/%.config/git/config%.local%.example'] = 'gitconfig',
    ['.*/%.config/git/config%.local'] = 'gitconfig',
    ['.*/%.config/swappy/config'] = 'ini',
    ['.*/%.config/uwsm/env'] = 'sh',
    ['.*/%.vscode/.*%.json'] = 'jsonc',
  },
}

vim.treesitter.language.register('starlark', 'tiltfile')
