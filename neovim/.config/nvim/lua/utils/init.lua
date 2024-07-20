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

  local first_col_limit = 1

  local function format_first_col(item)
    return get_item_fname(item) .. ':' .. item.lnum .. ':' .. item.col
  end

  for _, item in ipairs(items) do
    local first_col = format_first_col(item)

    if #first_col > first_col_limit then first_col_limit = #first_col end
  end

  local function format_item(item)
    if item.valid == 1 then
      local first_col = format_first_col(item)

      return ('%s │ %s'):format(
        first_col .. string.rep(' ', first_col_limit - #first_col),
        (item.type == '' and '' or item.type:upper() .. ' ') .. item.text
      )
    else
      return item.text
    end
  end

  return vim.tbl_map(
    format_item,
    vim.list_slice(items, info.start_idx, info.end_idx)
  )
end

return M
