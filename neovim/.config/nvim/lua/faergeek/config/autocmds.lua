local autocmd = require('faergeek.utils').autocmd
local keymap = require('faergeek.utils').keymap

autocmd(
  'Briefly highlight yanked text',
  'TextYankPost',
  function() vim.highlight.on_yank {} end
)

autocmd(
  'Disable concealing in help',
  'FileType',
  function() vim.opt_local.concealcursor = '' end,
  { pattern = { 'help' } }
)

autocmd(
  'Mark certain filetype buffers as unlisted',
  'FileType',
  function(event) vim.bo[event.buf].buflisted = false end,
  { pattern = { 'checkhealth' } }
)

autocmd(
  'Disable line wrapping in quickfix list',
  'FileType',
  function() vim.opt_local.wrap = false end,
  { pattern = { 'qf' } }
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
