return function(info)
  local items = info.quickfix == 1
      and vim.fn.getqflist({ id = info.id, items = 0 }).items
    or vim.fn.getloclist(info.winid, { id = info.id, items = 0 }).items

  local type_to_icon = { E = '', W = '', I = '', N = '' }

  local function get_icon(item)
    local icon = type_to_icon[item.type:upper()]
    return icon and icon .. ' ' or ''
  end

  local function get_location(item)
    if item.valid ~= 1 or (item.module == '' and item.bufnr == 0) then
      return ''
    end

    return ('%s:%d:%d│'):format(
      item.module == ''
          and vim.fn.fnamemodify(vim.fn.bufname(item.bufnr), ':p:~:.')
        or item.module,
      item.lnum,
      item.col
    )
  end

  local lines = {}
  for i = info.start_idx, info.end_idx do
    local item = items[i]

    local line = get_icon(item)
      .. get_location(item)
      .. item.text:gsub('\n', ' ')

    lines[#lines + 1] = line == '' and ' ' or line
  end

  return lines
end
