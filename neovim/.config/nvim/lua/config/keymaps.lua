local keymap = require('utils').keymap

keymap(
  'Move cursor up',
  { 'n', 'v' },
  'k',
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)

keymap(
  'Move cursor down',
  { 'n', 'v' },
  'j',
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)

keymap('Lazy', 'n', '<leader>l', '<cmd>:Lazy<cr>')

keymap('[D]iagnostic: Next', 'n', ']d', vim.diagnostic.goto_next)
keymap('[D]iagnostic: Prev', 'n', '[d', vim.diagnostic.goto_prev)

keymap('[S]how [D]iagnostics', 'n', '<leader>sd', vim.diagnostic.open_float)

keymap('LSP: [R]ename [S]ymbol', 'n', '<leader>rs', vim.lsp.buf.rename)
keymap('LSP: Code [A]ction', { 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action)

keymap('[F]ind [R]eferences', 'n', '<leader>fr', vim.lsp.buf.references)

keymap('[Q]uickfix: Next', 'n', ']q', vim.cmd.cnext, { silent = true })
keymap('[Q]uickfix: Prev', 'n', '[q', vim.cmd.cprevious, { silent = true })
