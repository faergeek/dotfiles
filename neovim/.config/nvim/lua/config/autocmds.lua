local autocmd = require('utils').autocmd
local keymap = require('utils').keymap

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

autocmd('Enable spell checking by default', 'FileType', function()
  vim.opt_local.spell = true
  vim.opt_local.spellfile = vim.fn.stdpath 'config' .. '/spell/words.add'
  vim.opt_local.spelllang = 'en_us,ru_ru'
  vim.opt_local.spelloptions:append { 'camel', 'noplainbuffer' }
end)

autocmd(
  'Disable spell checking in certain file types',
  'FileType',
  function() vim.opt_local.spell = false end,
  {
    pattern = {
      'dbout',
      'git',
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
  function(event)
    keymap('Close', 'n', 'q', '<Cmd>q<CR>', { buffer = event.buf })
  end,
  {
    pattern = {
      'checkhealth',
      'dap-float',
      'dap-repl',
      'dbout',
      'git',
      'help',
      'man',
      'qf',
      'query',
      'startuptime',
    },
  }
)

autocmd(
  'Map q to gq',
  'FileType',
  function(event)
    keymap('Close', 'n', 'q', 'gq', { buffer = event.buf, remap = true })
  end,
  {
    pattern = {
      'fugitive',
      'fugitiveblame',
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
