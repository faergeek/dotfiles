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

keymap('LSP: Document Symbols', 'n', 'gO', function()
  vim.lsp.buf.document_symbol {
    on_list = function(options)
      vim.fn.setloclist(0, {}, ' ', options)
      vim.cmd.lopen()
    end,
  }
end)

keymap('Find References', 'n', '<leader>fr', vim.lsp.buf.references)
keymap('Find Implementations', 'n', '<leader>fi', vim.lsp.buf.implementation)

keymap(
  'Show inlay hints until cursor is moved',
  'n',
  '<leader>i',
  require 'faergeek.utils.inlay-hint-keymap'
)

keymap('Next quickfix item', 'n', ']q', '<Cmd>cnext<CR>')
keymap('Previous quickfix item', 'n', '[q', '<Cmd>cprevious<CR>')

keymap('Next quickfix list', 'n', ']Q', '<Cmd>cnewer<CR>')
keymap('Previous quickfix list', 'n', '[Q', '<Cmd>colder<CR>')

keymap('Next loclist item', 'n', ']w', '<Cmd>lnext<CR>')
keymap('Previous loclist item', 'n', '[w', '<Cmd>lprevious<CR>')

keymap('Next loclist', 'n', ']W', '<Cmd>lnewer<CR>')
keymap('Previous loclist', 'n', '[W', '<Cmd>lolder<CR>')
