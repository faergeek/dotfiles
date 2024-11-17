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

keymap('Next quickfix item', 'n', ']q', '<Cmd>cnext<CR>')
keymap('Previous quickfix item', 'n', '[q', '<Cmd>cprevious<CR>')

keymap('Next quickfix list', 'n', ']Q', '<Cmd>cnewer<CR>')
keymap('Previous quickfix list', 'n', '[Q', '<Cmd>colder<CR>')

keymap('Next loclist item', 'n', ']w', '<Cmd>lnext<CR>')
keymap('Previous loclist item', 'n', '[w', '<Cmd>lprevious<CR>')

keymap('Next loclist', 'n', ']W', '<Cmd>lnewer<CR>')
keymap('Previous loclist', 'n', '[W', '<Cmd>lolder<CR>')
