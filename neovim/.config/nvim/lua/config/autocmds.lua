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
      'gitrebase',
      'kitty',
      'man',
      'qf',
      'samba',
      'sqls_output',
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
      'help',
      'qf',
      'query',
      'sqls_output',
      'startuptime',
    },
  }
)
