return function(INPUT_LINE_NUMBER, CURSOR_LINE, CURSOR_COLUMN)
  vim.keymap.set('n', 'q', '<Cmd>q<CR>', { buffer = 0 })

  vim.api.nvim_create_autocmd('StdinReadPre', {
    once = true,
    callback = function()
      vim.opt_local.list = false
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.scrolloff = 0
      vim.opt_local.sidescrolloff = 0
      vim.opt_local.signcolumn = 'no'

      vim.opt.cmdheight = 0
      vim.opt.laststatus = 0
    end,
  })

  vim.api.nvim_create_autocmd('StdinReadPost', {
    once = true,
    callback = function(event)
      local lines = vim.api.nvim_buf_get_lines(event.buf, 0, -1, true)
      vim.api.nvim_buf_set_lines(event.buf, 0, -1, true, {})

      vim.api.nvim_chan_send(
        vim.api.nvim_open_term(event.buf, {}),
        table.concat(lines, '\n')
      )
    end,
  })

  local function setCursor()
    if INPUT_LINE_NUMBER ~= 0 then
      vim.api.nvim_input(tostring(INPUT_LINE_NUMBER))
    end

    vim.api.nvim_input 'ggzt'

    if CURSOR_LINE ~= 0 then vim.api.nvim_input((CURSOR_LINE - 1) .. 'j') end

    vim.api.nvim_input '0'

    if CURSOR_COLUMN ~= 0 then
      vim.api.nvim_input((CURSOR_COLUMN - 1) .. 'l')
    end
  end

  vim.api.nvim_create_autocmd('TextChanged', {
    buffer = 0,
    once = true,
    callback = function() setCursor() end,
  })

  vim.api.nvim_create_autocmd('TermEnter', {
    buffer = 0,
    callback = function()
      vim.cmd.stopinsert()
      setCursor()
    end,
  })
end
