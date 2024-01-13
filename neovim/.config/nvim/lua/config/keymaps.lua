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

keymap('[T]ab: Next', 'n', ']t', vim.cmd.tabnext)
keymap('[T]ab: Prev', 'n', '[t', vim.cmd.tabprevious)

keymap('Lazy', 'n', '<leader>l', '<Cmd>Lazy<CR>')

keymap('[D]iagnostic: Next', 'n', ']d', vim.diagnostic.goto_next)
keymap('[D]iagnostic: Prev', 'n', '[d', vim.diagnostic.goto_prev)

keymap('[S]how [D]iagnostics', 'n', '<leader>sd', vim.diagnostic.open_float)

keymap('LSP: Hover Documentation', 'n', 'K', vim.lsp.buf.hover)
keymap('LSP: [R]ename [S]ymbol', 'n', '<leader>rs', vim.lsp.buf.rename)
keymap('LSP: Code [A]ction', { 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action)

keymap('LSP: Document Symbols', 'n', 'gO', function()
  local nr = vim.api.nvim_win_get_number(vim.api.nvim_get_current_win())

  vim.lsp.buf.document_symbol {
    on_list = function(options)
      vim.fn.setloclist(nr, {}, ' ', options)
      vim.cmd.windo { range = { nr }, args = { 'lopen' } }
    end,
  }
end)

keymap('[F]ind [R]eferences', 'n', '<leader>fr', vim.lsp.buf.references)

keymap('[Q]uickfix: Next', 'n', ']q', vim.cmd.cnext, { silent = true })
keymap('[Q]uickfix: Prev', 'n', '[q', vim.cmd.cprevious, { silent = true })

keymap('[Q]uickfix: Newer', 'n', ']Q', vim.cmd.cnewer, { silent = true })
keymap('[Q]uickfix: Older', 'n', '[Q', vim.cmd.colder, { silent = true })

keymap('Loclist ([W]in): Next', 'n', ']w', vim.cmd.lnext, { silent = true })
keymap('Loclist ([W]in): Prev', 'n', '[w', vim.cmd.lprevious, { silent = true })

keymap('Loclist ([W]in): Newer', 'n', ']W', vim.cmd.lnewer, { silent = true })
keymap('Loclist ([W]in): Older', 'n', '[W', vim.cmd.lolder, { silent = true })
