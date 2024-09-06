vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.cpoptions:append 'n'
vim.opt.cursorline = true
vim.opt.cursorlineopt = { 'number', 'screenline' }
vim.opt.diffopt:append {
  'algorithm:patience',
  'indent-heuristic',
}
vim.opt.expandtab = true
vim.opt.fillchars = {
  diff = ' ',
  fold = ' ',
  foldclose = '',
  foldopen = '',
}
vim.opt.foldcolumn = 'auto:1'
vim.opt.fixeol = false
vim.opt.foldtext = ''
vim.opt.guicursor =
  'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait300-blinkon200-blinkoff150'
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
  "{info -> v:lua.require('utils').quickfixtextfunc(info)}"
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.sessionoptions = {
  'buffers',
  'curdir',
  'folds',
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
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.showtabline = 0
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.spell = true
vim.opt.spellfile = vim.fn.stdpath 'config' .. '/spell/words.add'
vim.opt.spelllang = 'en_us,ru_ru'
vim.opt.spelloptions:append { 'camel' }
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.switchbuf:append { 'useopen' }
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.wildoptions:append { 'fuzzy' }

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
  virtual_text = {
    prefix = function(diagnostic)
      if diagnostic.severity == vim.diagnostic.severity.ERROR then
        return ''
      elseif diagnostic.severity == vim.diagnostic.severity.HINT then
        return ''
      elseif diagnostic.severity == vim.diagnostic.severity.INFO then
        return ''
      elseif diagnostic.severity == vim.diagnostic.severity.WARN then
        return ''
      end

      return '●'
    end,
    spacing = 0,
    source = true,
  },
}

vim.filetype.add {
  extension = {
    mli = 'ocamlinterface',
  },
  filename = {
    ['Tiltfile'] = 'tiltfile',
    ['todo.txt'] = 'todotxt',
  },
  pattern = {
    ['%.env%..+'] = 'sh',
    ['.*/%.config/git/config%.local'] = 'gitconfig',
    ['.*/%.config/git/config%.local%.example'] = 'gitconfig',
    ['.*/%.config/hypr/.*%.conf'] = 'hyprlang',
    ['.*/%.config/imv/config'] = 'dosini',
    ['.*/%.config/waybar/config'] = 'jsonc',
  },
}

vim.treesitter.language.register('starlark', 'tiltfile')
