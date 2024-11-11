local M = {}

local group = vim.api.nvim_create_augroup('config', { clear = true })

--- @param desc string
--- @param event string | string[]
--- @param callbackOrCommand string | function
--- @param opts? table<string, any>
--- @return number
function M.autocmd(desc, event, callbackOrCommand, opts)
  opts = opts or {}
  opts.desc = desc
  opts.group = group

  if type(callbackOrCommand) == 'string' then
    opts.command = callbackOrCommand
  else
    opts.callback = callbackOrCommand
  end

  return vim.api.nvim_create_autocmd(event, opts)
end

---@param desc string
---@param mode string|table
---@param lhs string
---@param rhs string|function
---@param opts table|nil
function M.keymap(desc, mode, lhs, rhs, opts)
  opts = opts or {}
  opts.desc = desc

  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.buf_is_empty(bufnr)
  vim.validate { bufnr = { bufnr, 'number', true } }

  if not bufnr or bufnr == 0 then bufnr = vim.api.nvim_get_current_buf() end

  return vim.api.nvim_buf_line_count(bufnr) < 2
    and #vim.fn.getbufoneline(bufnr, 1) == 0
end

function M.quickfixtextfunc(info)
  local items = info.quickfix == 1
      and vim.fn.getqflist({
        id = info.id,
        items = 0,
      }).items
    or vim.fn.getloclist(info.winid, { id = info.id, items = 0 }).items

  local function get_item_fname(item)
    local fname = item.bufnr > 0 and vim.fn.bufname(item.bufnr) or ''

    if fname == '' then
      fname = '[No Name]'
    else
      fname = vim.fn.fnamemodify(fname, ':p:~:.')
    end

    return fname
  end

  local function is_valid(item) return item.valid == 1 end

  local fname_col_width = 1
  local function format_fname_col(item)
    return is_valid(item) and get_item_fname(item) or ''
  end

  local pos_col_width = 1
  local function format_pos_col(item)
    return is_valid(item) and ('%d:%d'):format(item.lnum, item.col) or ''
  end

  for _, item in ipairs(items) do
    fname_col_width = math.max(fname_col_width, #format_fname_col(item))
    pos_col_width = math.max(pos_col_width, #format_pos_col(item))
  end

  local format_str = (
    '%-'
    .. fname_col_width
    .. 's ┃ %'
    .. pos_col_width
    .. 's ┃ %-1s %s'
  )

  local type_to_icon = {
    E = '',
    W = '',
  }

  return vim.tbl_map(
    function(item)
      return format_str
        :format(
          format_fname_col(item),
          format_pos_col(item),
          type_to_icon[item.type:upper()] or '',
          item.text:gsub('\n', ' ')
        )
        :sub(1, 1000)
    end,
    items
  )
end

function M.kitty_scrollback(INPUT_LINE_NUMBER, CURSOR_LINE, CURSOR_COLUMN)
  require('lualine').hide {
    place = { 'statusline', 'tabline', 'winbar' },
    unhide = false,
  }

  vim.opt.cmdheight = 0
  vim.cmd [[
    hi! TermCursor guifg=NONE guibg=NONE gui=NONE cterm=NONE
    hi! TermCursorNC guifg=NONE guibg=NONE gui=NONE cterm=NONE
  ]]
  vim.opt.guicursor = 'a:noCursor'
  vim.opt.laststatus = 0
  vim.opt.list = false
  vim.opt.number = false
  vim.opt.relativenumber = false
  vim.opt.scrollback = INPUT_LINE_NUMBER + CURSOR_LINE
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

  M.autocmd(
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

  M.keymap('Close on <q>', 'n', 'q', '<Cmd>q<CR>', {
    buffer = 0,
  })
end

return M
