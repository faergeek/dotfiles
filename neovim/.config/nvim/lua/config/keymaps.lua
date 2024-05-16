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

keymap('Next diagnostic', 'n', ']d', vim.diagnostic.goto_next)
keymap('Previous diagnostic', 'n', '[d', vim.diagnostic.goto_prev)

keymap('Show Diagnostics', 'n', '<leader>sd', vim.diagnostic.open_float)

keymap('LSP: Hover', 'n', 'K', vim.lsp.buf.hover)
keymap('LSP: Rename Symbol', 'n', '<leader>rs', vim.lsp.buf.rename)
keymap('LSP: Code Action', { 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action)

keymap('LSP: Document Symbols', 'n', 'gO', function()
  local nr = vim.api.nvim_win_get_number(vim.api.nvim_get_current_win())

  vim.lsp.buf.document_symbol {
    on_list = function(options)
      vim.fn.setloclist(nr, {}, ' ', options)
      vim.cmd.windo { range = { nr }, args = { 'lopen' } }
    end,
  }
end)

keymap('Find References', 'n', '<leader>fr', vim.lsp.buf.references)

keymap('Next quickfix item', 'n', ']q', vim.cmd.cnext)
keymap('Previous quickfix item', 'n', '[q', vim.cmd.cprevious)

keymap('Next quickfix list', 'n', ']Q', vim.cmd.cnewer)
keymap('Previous quickfix list', 'n', '[Q', vim.cmd.colder)

keymap('Next loclist item', 'n', ']w', vim.cmd.lnext)
keymap('Previous loclist item', 'n', '[w', vim.cmd.lprevious)

keymap('Next loclist', 'n', ']W', vim.cmd.lnewer)
keymap('Previous loclist', 'n', '[W', vim.cmd.lolder)
