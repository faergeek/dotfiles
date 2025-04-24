return function(INPUT_LINE_NUMBER, CURSOR_LINE, CURSOR_COLUMN)
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
