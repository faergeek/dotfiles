local autocmd = require('faergeek.utils').autocmd
local keymap = require('faergeek.utils').keymap

autocmd(
  'Briefly highlight yanked text',
  'TextYankPost',
  function() vim.highlight.on_yank {} end
)

autocmd('Override options for terminal buffers', 'TermOpen', function()
  vim.opt_local.spell = false
  vim.opt_local.signcolumn = 'auto'
end)

autocmd(
  'Disable concealing in help',
  'FileType',
  function() vim.opt_local.concealcursor = '' end,
  { pattern = { 'help' } }
)

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
      'man',
      'qf',
      'query',
      'startuptime',
    },
  }
)

autocmd('Close help buffers with just <q>', 'BufReadPost', function(event)
  if vim.bo[event.buf].buftype ~= 'help' then return end

  keymap('Close', 'n', 'q', '<Cmd>q<CR>', { buffer = event.buf })
end)

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
