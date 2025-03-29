local autocmd = require('faergeek.utils').autocmd
local keymap = require('faergeek.utils').keymap

return function(INPUT_LINE_NUMBER, CURSOR_LINE, CURSOR_COLUMN)
  vim.opt.cmdheight = 0
  vim.opt.laststatus = 0
  vim.opt.list = false
  vim.opt.number = false
  vim.opt.relativenumber = false
  vim.opt.scrolloff = 0
  vim.opt.signcolumn = 'no'

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local line_count = #lines

  local setCursor = function()
    vim.api.nvim_feedkeys(tostring(INPUT_LINE_NUMBER) .. 'ggzt', 'n', true)

    local line = line_count
    if CURSOR_LINE <= line then line = CURSOR_LINE end

    vim.api.nvim_feedkeys(tostring(line - 1) .. 'j', 'n', true)
    vim.api.nvim_feedkeys('0', 'n', true)
    vim.api.nvim_feedkeys(tostring(CURSOR_COLUMN - 1) .. 'l', 'n', true)
  end

  local term_buf = vim.api.nvim_create_buf(true, false)
  local term_io = vim.api.nvim_open_term(term_buf, {})

  for i, line in ipairs(lines) do
    vim.api.nvim_chan_send(term_io, line)

    if i < line_count then vim.api.nvim_chan_send(term_io, '\r\n') end
  end

  vim.api.nvim_buf_delete(0, { force = true })
  vim.api.nvim_win_set_buf(0, term_buf)
  vim.schedule(setCursor)

  autocmd(
    'Just reset cursor position when trying to enter terminal mode',
    'ModeChanged',
    function()
      local mode = vim.fn.mode()
      if mode == 't' then
        vim.cmd.stopinsert()
        vim.schedule(setCursor)
      end
    end,
    { buffer = 0 }
  )

  keymap('Close on <q>', 'n', 'q', '<Cmd>q<CR>', {
    buffer = 0,
  })
end
