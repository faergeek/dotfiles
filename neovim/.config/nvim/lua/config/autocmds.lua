local autocmd = require('utils').autocmd

autocmd(
  'Briefly highlight yanked text',
  'TextYankPost',
  function() vim.highlight.on_yank {} end
)

autocmd('Override options for terminal buffers', 'TermOpen', function()
  vim.opt_local.spell = false
  vim.opt_local.signcolumn = 'auto'
end)

autocmd('Disable concealing in help', 'FileType', function()
  vim.opt_local.conceallevel = 0
  vim.opt_local.concealcursor = ''
end, { pattern = { 'help' } })

autocmd(
  'Set options specific to Man',
  'FileType',
  function() vim.opt_local.signcolumn = 'auto' end,
  { pattern = { 'man' } }
)

autocmd(
  'Disable spell checking in certain file types',
  'FileType',
  function() vim.opt_local.spell = false end,
  {
    pattern = {
      'dbout',
      'git',
      'gitrebase',
      'kitty',
      'man',
      'qf',
      'samba',
    },
  }
)

autocmd(
  'Mark certain filetype buffers as unlisted',
  'FileType',
  function(event) vim.bo[event.buf].buflisted = false end,
  { pattern = { 'checkhealth' } }
)

autocmd(
  'Close certain filetype buffers with just <q>',
  'FileType',
  function(event) vim.keymap.set('n', 'q', '<Cmd>q<CR>', { buffer = event.buf }) end,
  {
    pattern = {
      'checkhealth',
      'dap-float',
      'dap-repl',
      'dbout',
      'fugitive',
      'fugitiveblame',
      'git',
      'help',
      'qf',
      'query',
      'startuptime',
    },
  }
)

autocmd('Setup LSP clients', 'LspAttach', function(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  if client then
    if client.name == 'eslint' then
      client.server_capabilities.documentFormattingProvider = true
    elseif client.name == 'dockerls' then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end
end)
