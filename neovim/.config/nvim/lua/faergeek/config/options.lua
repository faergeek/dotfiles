vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.cpoptions:append 'n'
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
vim.opt.fillchars = {
  diff = ' ',
  fold = ' ',
  foldclose = '',
  foldopen = '',
}
vim.opt.foldcolumn = 'auto:9'
vim.opt.fixeol = false
vim.opt.foldtext = ''
vim.opt.guicursor =
  'n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20,a:blinkwait300-blinkon200-blinkoff150'
vim.opt.guifont = 'FantasqueSansM Nerd Font'
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.jumpoptions = 'view'
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
vim.opt.quickfixtextfunc =
  "{info -> v:lua.require('faergeek.utils.quickfixtextfunc')(info)}"
vim.opt.relativenumber = true
vim.opt.ruler = false
vim.opt.scrolloff = 8
vim.opt.sessionoptions = { 'tabpages', 'winsize' }
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
vim.opt.switchbuf = { 'usetab', 'newtab' }
vim.opt.tabline = '%!v:lua.tabline()'
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.wildignorecase = true
vim.opt.wildoptions:append { 'fuzzy' }

if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy '+',
      ['*'] = require('vim.ui.clipboard.osc52').copy '*',
    },
    paste = {
      ['+'] = function() return vim.split(vim.fn.getreg '0', '\n') end,
      ['*'] = function() return vim.split(vim.fn.getreg '0', '\n') end,
    },
  }
end

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.g.qf_disable_statusline = true
vim.g.zig_fmt_autosave = false

vim.diagnostic.config {
  severity_sort = true,
  signs = {
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticVirtualTextError',
      [vim.diagnostic.severity.HINT] = 'DiagnosticVirtualTextHint',
      [vim.diagnostic.severity.INFO] = 'DiagnosticVirtualTextInfo',
      [vim.diagnostic.severity.WARN] = 'DiagnosticVirtualTextWarn',
    },
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.HINT] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.WARN] = '',
    },
  },
}

vim.filetype.add {
  extension = {
    mli = 'ocamlinterface',
    mll = 'ocamllex',
    mly = 'ocamllex',
  },
  filename = {
    ['.eslintignore'] = 'gitignore',
    ['.ignore'] = 'gitignore',
    ['.prettierignore'] = 'gitignore',
    ['.swcrc'] = 'jsonc',
    ['Tiltfile'] = 'tiltfile',
  },
  pattern = {
    ['.*/%.config/git/config%.local%.example'] = 'gitconfig',
    ['.*/%.config/git/config%.local'] = 'gitconfig',
    ['.*/%.config/git/theme'] = 'gitconfig',
    ['.*/%.config/hypr/.*%.conf'] = 'hyprlang',
    ['.*/%.config/waybar/config'] = 'jsonc',
    ['.*/%.vscode/.*%.json'] = 'jsonc',
  },
}

vim.highlight.priorities.semantic_tokens = 90
vim.treesitter.language.register('starlark', 'tiltfile')
