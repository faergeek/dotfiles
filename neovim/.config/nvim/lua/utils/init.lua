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

return M
