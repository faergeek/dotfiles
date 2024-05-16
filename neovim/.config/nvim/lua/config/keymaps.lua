local keymap = require('utils').keymap

keymap(
  'Move cursor up',
  { 'n', 'x' },
  'k',
  "v:count ? 'k' : 'gk'",
  { expr = true }
)

keymap(
  'Move cursor down',
  { 'n', 'x' },
  'j',
  "v:count ? 'j' : 'gj'",
  { expr = true }
)

keymap('Lazy', 'n', '<leader>l', '<Cmd>Lazy<CR>')

-- TODO: remove once neovim 0.10 is available on all relevant machines
keymap('Next diagnostic', 'n', ']d', vim.diagnostic.goto_next)
keymap('Previous diagnostic', 'n', '[d', vim.diagnostic.goto_prev)

keymap('Show Diagnostics', 'n', '<C-W>d', vim.diagnostic.open_float)

keymap('LSP: Hover', 'n', 'K', vim.lsp.buf.hover)
-- /TODO
keymap('LSP: Rename Symbol', 'n', '<leader>rs', vim.lsp.buf.rename)
keymap('LSP: Code Action', { 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action)

keymap('Find References', 'n', '<leader>fr', vim.lsp.buf.references)

keymap('Next quickfix item', 'n', ']q', vim.cmd.cnext)
keymap('Previous quickfix item', 'n', '[q', vim.cmd.cprevious)

keymap('Next quickfix list', 'n', ']Q', vim.cmd.cnewer)
keymap('Previous quickfix list', 'n', '[Q', vim.cmd.colder)
