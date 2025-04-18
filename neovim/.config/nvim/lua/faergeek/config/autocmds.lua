vim.api.nvim_create_autocmd(
  'TextYankPost',
  { callback = function() vim.hl.on_yank {} end }
)

vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(event)
    if vim.bo.buftype == 'help' then
      vim.keymap.set('n', 'q', '<Cmd>q<CR>', { buffer = event.buf })
    end
  end,
})
