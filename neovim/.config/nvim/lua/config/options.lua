vim.opt.backupcopy = 'yes'
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.cpoptions:append 'n'
vim.opt.cursorline = true
vim.opt.cursorlineopt = { 'number', 'screenline' }
vim.opt.diffopt:append {
  'algorithm:patience',
  'indent-heuristic',
  'linematch:60',
}
vim.opt.expandtab = true
vim.opt.fillchars = {
  diff = '╱',
}
vim.opt.fixeol = false
vim.opt.guicursor =
  'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait300-blinkon200-blinkoff150'
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
  "{info -> v:lua.require('utils').quickfixtextfunc(info)}"
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.opt.sessionoptions = {
  'buffers',
  'curdir',
  'help',
  'skiprtp',
  'tabpages',
  'terminal',
  'winsize',
}
vim.opt.shiftround = true
vim.opt.shiftwidth = 0
vim.opt.shortmess:append {
  S = true,
  W = true,
  I = true,
  c = true,
}
vim.opt.showbreak = '↳ '
vim.opt.showcmdloc = 'statusline'
vim.opt.showmode = false
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.spell = true
vim.opt.spelllang = 'en_us,ru_ru'
vim.opt.spelloptions:append { 'camel' }
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 200
vim.opt.wildoptions:append { 'fuzzy' }

vim.g.zig_fmt_autosave = false

vim.diagnostic.config {
  severity_sort = true,
  signs = false,
}

vim.filetype.add {
  filename = {
    ['todo.txt'] = 'todotxt',
  },
  pattern = {
    ['.env%..+'] = 'sh',
  },
}
