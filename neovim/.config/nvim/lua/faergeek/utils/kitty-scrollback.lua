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

  local term_buf = vim.api.nvim_create_buf(false, true)
  local term_io = vim.api.nvim_open_term(term_buf, {})

  vim.api.nvim_chan_send(term_io, table.concat(lines, '\r\n'))
  vim.api.nvim_buf_delete(0, { force = true })
  vim.api.nvim_win_set_buf(0, term_buf)
  vim.schedule(setCursor)

  vim.api.nvim_create_autocmd('ModeChanged', {
    buffer = 0,
    callback = function()
      local mode = vim.api.nvim_get_mode().mode
      if mode == 't' then
        vim.cmd.stopinsert()
        vim.schedule(setCursor)
      end
    end,
  })

  vim.keymap.set('n', 'q', '<Cmd>q<CR>', { buffer = true })
end
