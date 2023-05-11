vim.opt.backupcopy = 'yes'
vim.opt.breakindent = true
vim.opt.breakindentopt = 'sbr'
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.cpoptions:append 'n'
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.gdefault = true
vim.opt.guicursor =
  'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait300-blinkon200-blinkoff150'
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
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
vim.opt.scrolloff = 3
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append { W = true, I = true, c = true }
vim.opt.showbreak = '↳ '
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.undofile = true
vim.opt.updatetime = 200
vim.opt.wildmode = 'longest:full,full'

vim.fn.sign_define {
  {
    text = '',
    name = 'DiagnosticSignError',
    numhl = 'DiagnosticSignError',
    texthl = 'DiagnosticSignError',
  },
  {
    text = '',
    name = 'DiagnosticSignWarn',
    numhl = 'DiagnosticSignWarn',
    texthl = 'DiagnosticSignWarn',
  },
  {
    text = '',
    name = 'DiagnosticSignHint',
    numhl = 'DiagnosticSignHint',
    texthl = 'DiagnosticSignHint',
  },
  {
    text = '',
    name = 'DiagnosticSignInfo',
    numhl = 'DiagnosticSignInfo',
    texthl = 'DiagnosticSignInfo',
  },
}