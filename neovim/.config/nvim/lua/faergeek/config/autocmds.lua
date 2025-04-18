vim.api.nvim_create_autocmd(
  'TextYankPost',
  { callback = function() vim.hl.on_yank {} end }
)

vim.api.nvim_create_autocmd('FileType', {
  callback = function(event) vim.bo[event.buf].buflisted = false end,
  pattern = { 'checkhealth' },
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function(event)
    vim.keymap.set('n', 'q', '<Cmd>q<CR>', { buffer = event.buf })
  end,
  pattern = {
    'checkhealth',
    'dap-float',
    'dap-repl',
    'dbout',
    'git',
    'query',
    'startuptime',
  },
})

vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(event)
    if vim.bo[event.buf].buftype ~= 'help' then return end

    vim.keymap.set('n', 'q', '<Cmd>q<CR>', { buffer = event.buf })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function(event)
    vim.keymap.set('n', 'q', 'gq', { buffer = event.buf, remap = true })
  end,
  pattern = {
    'fugitive',
    'fugitiveblame',
  },
})
