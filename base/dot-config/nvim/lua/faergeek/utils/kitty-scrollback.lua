return function(INPUT_LINE_NUMBER, CURSOR_LINE, CURSOR_COLUMN)
  local buf = vim.api.nvim_get_current_buf()
  local term_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, term_buf)

  vim.opt_local.list = false
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.scrolloff = 0
  vim.opt_local.signcolumn = 'no'

  vim.api.nvim_chan_send(
    vim.api.nvim_open_term(term_buf, {}),
    table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), '\r\n')
  )

  vim.api.nvim_buf_delete(buf, { force = true })

  vim.keymap.set('n', 'q', '<Cmd>q<CR>', { buffer = term_buf })
  vim.opt.cmdheight = 0
  vim.opt.laststatus = 0

  local setCursor = vim.schedule_wrap(
    function()
      vim.fn.winrestview {
        col = CURSOR_COLUMN - 1,
        curswant = CURSOR_COLUMN - 1,
        lnum = math.max(
          1,
          math.min(
            INPUT_LINE_NUMBER + CURSOR_LINE - 1,
            vim.api.nvim_buf_line_count(0)
          )
        ),
        topline = INPUT_LINE_NUMBER,
      }
    end
  )

  vim.api.nvim_create_autocmd('TermEnter', {
    buffer = 0,
    callback = function()
      vim.cmd.stopinsert()
      setCursor()
    end,
  })

  setCursor()
end
