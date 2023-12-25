local M = {}

local group = vim.api.nvim_create_augroup('config', { clear = true })

function M.autocmd(desc, event, callbackOrCommand, opts)
  opts = opts or {}
  opts.desc = desc
  opts.group = group

  if type(callbackOrCommand) == 'string' then
    opts.command = callbackOrCommand
  else
    opts.callback = callbackOrCommand
  end

  vim.api.nvim_create_autocmd(event, opts)
end

function M.keymap(desc, modes, lhs, rhs, opts)
  opts = opts or {}
  opts.desc = desc

  vim.keymap.set(modes, lhs, rhs, opts)
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
      fname = vim.fn.fnamemodify(fname, ':p:.')
    end

    return fname
  end

  local fname_limit = 1
  local lnum_limit = 1
  local col_limit = 1

  for _, item in ipairs(items) do
    local fname = get_item_fname(item)
    local lnum = '' .. item.lnum
    local col = '' .. item.col

    if #fname > fname_limit then fname_limit = #fname end
    if #lnum > lnum_limit then lnum_limit = #lnum end
    if #col > col_limit then col_limit = #col end
  end

  local function format_item(item)
    if item.valid == 1 then
      local fname = get_item_fname(item)
      local lnum = '' .. item.lnum
      local col = '' .. item.col

      return ('%s | %s:%s | %s %s'):format(
        fname .. string.rep(' ', fname_limit - #fname),
        string.rep(' ', lnum_limit - #lnum) .. lnum,
        col .. string.rep(' ', col_limit - #col),
        item.type == '' and '' or ' ' .. item.type:sub(1, 1):upper(),
        item.text:gsub('^%s+', '')
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
