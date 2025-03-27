local keymap = require('faergeek.utils').keymap

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

keymap('LSP: Rename Symbol', 'n', '<leader>rs', vim.lsp.buf.rename)
keymap('LSP: Code Action', { 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action)

keymap('Find References', 'n', '<leader>fr', vim.lsp.buf.references)
keymap('Find Implementations', 'n', '<leader>fi', vim.lsp.buf.implementation)

keymap(
  'Show inlay hints until cursor is moved',
  'n',
  '<leader>i',
  require 'faergeek.utils.inlay-hint-keymap'
)

if vim.fn.has 'nvim-0.11' == 0 then
  keymap(':cnext', 'n', ']q', '<Cmd>cnext<CR>')
  keymap(':cprevious', 'n', '[q', '<Cmd>cprevious<CR>')
end
