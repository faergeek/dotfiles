require 'plugins'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.textwidth = 80
vim.opt.wrap = false

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false

vim.opt.list = true
vim.opt.listchars = 'tab:» ,extends:⤳,precedes:⬿,trail:·,nbsp:␣'

vim.opt.showmode = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 20
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.backupcopy = 'yes'

vim.opt.sessionoptions =
  'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals'

vim.opt.completeopt = { 'menuone', 'noselect' }

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set(
  'n',
  'k',
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)

vim.keymap.set(
  'n',
  'j',
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')

local init = vim.api.nvim_create_augroup('init', {
  clear = true,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = init,
  desc = 'Automatically reload config on save',
  pattern = {
    vim.env.MYVIMRC,
    vim.fs.dirname(vim.env.MYVIMRC) .. '/lua/**/*',
  },
  command = 'source <afile> | PackerCompile',
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = init,
  desc = 'Briefly highlight yanked text',
  callback = function()
    vim.highlight.on_yank()
  end,
})
