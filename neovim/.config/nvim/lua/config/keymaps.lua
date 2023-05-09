local keymap = require('utils').keymap

keymap('Help', 'n', '?', ':help ')

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

keymap('Move selection up', 'v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
keymap('Move selection down', 'v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

keymap('Indent', 'v', '<', '<gv')
keymap('Dedent', 'v', '>', '>gv')

keymap('Lazy', 'n', '<leader>l', '<cmd>:Lazy<cr>')

keymap('Diagnostic: Next item', 'n', ']d', vim.diagnostic.goto_next)
keymap('Diagnostic: Previous item', 'n', '[d', vim.diagnostic.goto_prev)

keymap('[S]how [D]iagnostics', 'n', '<leader>sd', vim.diagnostic.open_float)

keymap('LSP: [R]ename [S]ymbol', 'n', '<leader>rs', vim.lsp.buf.rename)
keymap('LSP: Code [A]ction', { 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action)
