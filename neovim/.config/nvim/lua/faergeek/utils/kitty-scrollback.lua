return function(INPUT_LINE_NUMBER, CURSOR_LINE, CURSOR_COLUMN)
  vim.opt.cmdheight = 0
  vim.opt.laststatus = 0

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
