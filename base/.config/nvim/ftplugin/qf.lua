vim.opt_local.listchars:remove {
  'leadmultispace',
  'multispace',
  'trail',
}
vim.opt_local.signcolumn = 'auto'
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.keymap.set('n', 'q', '<Cmd>q<CR>', { buffer = 0 })
