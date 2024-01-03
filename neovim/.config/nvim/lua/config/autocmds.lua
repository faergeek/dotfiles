local autocmd = require('utils').autocmd

autocmd(
  'Briefly highlight yanked text',
  'TextYankPost',
  function() vim.highlight.on_yank {} end
)

autocmd(
  'Override options for terminal buffers',
  'TermOpen',
  function() vim.opt_local.signcolumn = 'auto' end
)

autocmd('Close terminal if job exited without an error', 'TermClose', function()
  if vim.v.event.status == 0 then vim.api.nvim_buf_delete(0, {}) end
end)

autocmd(
  'Resize windows when terminal resizes',
  'VimResized',
  function() vim.cmd 'tabdo wincmd =' end
)

autocmd('Disable concealing in help', 'FileType', function()
  vim.wo.conceallevel = 0
  vim.wo.concealcursor = ''
end, {
  pattern = { 'help' },
})

autocmd(
  'Disable signcolumn in man',
  'FileType',
  function() vim.wo.signcolumn = 'auto' end,
  {
    pattern = { 'man' },
  }
)

autocmd('Close certain filetypes with just <q>', 'FileType', function(event)
  vim.bo[event.buf].buflisted = false
  vim.keymap.set('n', 'q', ':q<CR>', { buffer = event.buf, silent = true })
end, {
  pattern = {
    'checkhealth',
    'help',
    'lspinfo',
    'man',
    'qf',
    'query',
    'startuptime',
  },
})

autocmd(
  'Enable spell checking for certain filetypes',
  'FileType',
  function() vim.opt_local.spell = true end,
  { pattern = { 'gitcommit', 'markdown' } }
)

local function supports_document_highlights(client)
  return client.server_capabilities.documentHighlightProvider
end

autocmd('Document Highlight', 'CursorHold', function(event)
  local clients = vim.lsp.get_active_clients {
    bufnr = event.buf,
  }

  local supported =
    not vim.tbl_isempty(vim.tbl_filter(supports_document_highlights, clients))

  if supported then vim.lsp.buf.document_highlight() end
end)

autocmd(
  'Clear All the References',
  'CursorMoved',
  function() vim.lsp.buf.clear_references() end
)
