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
  local limit = 31

  local function format_item(item)
    if item.valid == 1 then
      local fname = ''

      if item.bufnr > 0 then
        fname = vim.fn.bufname(item.bufnr)

        if fname == '' then
          fname = '[No Name]'
        else
          fname = fname:gsub('^' .. vim.env.HOME, '~')
        end

        if #fname <= limit then
          fname = ('%-' .. limit .. 's'):format(fname)
        else
          fname = ('…%.' .. (limit - 1) .. 's'):format(fname:sub(1 - limit))
        end
      end

      return ('%s |%5d:%-3d|%s %s'):format(
        fname,
        item.lnum > 99999 and -1 or item.lnum,
        item.col > 999 and -1 or item.col,
        item.type == '' and '' or ' ' .. item.type:sub(1, 1):upper(),
        item.text
      )
    else
      return item.text
    end
  end

  local items = info.quickfix == 1
      and vim.fn.getqflist({
        id = info.id,
        items = 0,
      }).items
    or vim.fn.getloclist(info.winid, { id = info.id, items = 0 }).items

  return vim.tbl_map(
    format_item,
    vim.list_slice(items, info.start_idx, info.end_idx)
  )
end

return M
