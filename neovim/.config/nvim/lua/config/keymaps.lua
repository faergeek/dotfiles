local autocmd = require('utils').autocmd
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

keymap('LSP: Rename Symbol', 'n', '<leader>rs', vim.lsp.buf.rename)
keymap('LSP: Code Action', { 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action)

keymap('Find References', 'n', '<leader>fr', vim.lsp.buf.references)
keymap('Find Implementations', 'n', '<leader>fi', vim.lsp.buf.implementation)

if vim.lsp.inlay_hint then
  keymap('Show inlay hints until cursor is moved', 'n', '<leader>i', function()
    vim.lsp.inlay_hint.enable(true)

    autocmd(
      'Hide inlay hint once cursor is moved',
      'CursorMoved',
      function() vim.lsp.inlay_hint.enable(false) end,
      { once = true }
    )
  end)
end

keymap('Next quickfix item', 'n', ']q', vim.cmd.cnext)
keymap('Previous quickfix item', 'n', '[q', vim.cmd.cprevious)

keymap('Next quickfix list', 'n', ']Q', vim.cmd.cnewer)
keymap('Previous quickfix list', 'n', '[Q', vim.cmd.colder)

for i = 1, 9, 1 do
  keymap('Previous quickfix list', 'n', '<C-' .. i .. '>', '<C-w>' .. i .. 'w')
end
