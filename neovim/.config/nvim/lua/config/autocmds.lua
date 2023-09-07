local autocmd = require('utils').autocmd
local keymap = require('utils').keymap
local lsp_handle_capability = require('utils').lsp_handle_capability

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

autocmd('Setup LSP', 'LspAttach', function(event)
  local client = vim.lsp.get_client_by_id(event.data.client_id)

  lsp_handle_capability(
    event.buf,
    client,
    'hoverProvider',
    function()
      keymap(
        'LSP: Hover Documentation',
        'n',
        'K',
        vim.lsp.buf.hover,
        { buffer = event.buf }
      )
    end
  )

  lsp_handle_capability(
    event.buf,
    client,
    'implementationProvider',
    function()
      keymap(
        'LSP: [G]o to [i]mplementation',
        'n',
        'gi',
        vim.lsp.buf.implementation,
        { buffer = event.buf }
      )
    end
  )

  lsp_handle_capability(
    event.buf,
    client,
    'documentHighlightProvider',
    function()
      autocmd(
        'Document Highlight',
        'CursorHold',
        vim.lsp.buf.document_highlight,
        { buffer = event.buf }
      )

      autocmd(
        'Clear All the References',
        'CursorMoved',
        vim.lsp.buf.clear_references,
        { buffer = event.buf }
      )
    end
  )
end)
