vim.opt.breakindent = true
if not vim.env.SSH_TTY then vim.opt.clipboard = 'unnamedplus' end
vim.opt.cursorline = true
vim.opt.cursorlineopt = { 'number', 'screenline' }
vim.opt.diffopt = {
  'algorithm:patience',
  'closeoff',
  'filler',
  'indent-heuristic',
  'internal',
}
vim.opt.expandtab = true
vim.opt.exrc = true
vim.opt.fillchars = {
  diff = ' ',
  fold = ' ',
  foldclose = '',
  foldopen = '',
}
vim.opt.fixeol = false
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldtext = ''
vim.opt.guicursor =
  'n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20,a:blinkwait300-blinkon200-blinkoff150'
vim.opt.guifont = 'FantasqueSansM Nerd Font'
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.jumpoptions:append 'view'
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = {
  extends = '…',
  leadmultispace = ' ',
  multispace = '·',
  nbsp = '␣',
  precedes = '…',
  tab = '» ',
  trail = '·',
}
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = false
vim.opt.scrolloff = 8
vim.opt.sessionoptions = { 'buffers', 'tabpages', 'winsize' }
vim.opt.shiftround = true
vim.opt.shiftwidth = 0
vim.opt.shortmess:append {
  W = true,
  I = true,
  c = true,
}
vim.opt.showbreak = '↳ '
vim.opt.showmatch = true
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.statusline = '%!v:lua.statusline()'
vim.opt.tabline = '%!v:lua.tabline()'
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.wildignorecase = true
vim.opt.wildoptions:append { 'fuzzy' }

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.diagnostic.config {
  float = {
    scope = 'cursor',
  },
  severity_sort = true,
  signs = false,
}

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
    ['.*/%.config/git/config%.local%.example'] = 'gitconfig',
    ['.*/%.config/git/config%.local'] = 'gitconfig',
    ['.*/%.config/git/theme'] = 'gitconfig',
    ['.*/%.vscode/.*%.json'] = 'jsonc',
  },
}

vim.hl.priorities.semantic_tokens = 90
vim.treesitter.language.register('starlark', 'tiltfile')
