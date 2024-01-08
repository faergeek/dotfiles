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

autocmd(
  'Close terminal if job exited without an error',
  'TermClose',
  function(event)
    if vim.v.event.status == 0 then vim.api.nvim_buf_delete(event.buf, {}) end
  end
)

autocmd(
  'Resize windows when terminal resizes',
  'VimResized',
  function() vim.cmd 'tabdo wincmd =' end
)

autocmd(
  'Set filetype for .env files',
  { 'BufNewFile', 'BufRead' },
  function() vim.opt.filetype = 'sh' end,
  { pattern = { '.env', '.env.*' } }
)

autocmd('Disable concealing in help', 'FileType', function()
  vim.opt_local.conceallevel = 0
  vim.opt_local.concealcursor = ''
end, { pattern = { 'help' } })

autocmd('Set options specific to Man', 'FileType', function()
  vim.opt_local.spell = false
  vim.opt_local.signcolumn = 'auto'
end, { pattern = { 'man' } })

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
