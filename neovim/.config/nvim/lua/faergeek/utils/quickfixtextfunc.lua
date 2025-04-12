return function(info)
  local items = info.quickfix == 1
      and vim.fn.getqflist({ id = info.id, items = 0 }).items
    or vim.fn.getloclist(info.winid, { id = info.id, items = 0 }).items

  local type_to_icon = { E = '', W = '', I = '', N = '' }

  local lines = {}
  for i = info.start_idx, info.end_idx do
    local item = items[i]

    local icon = type_to_icon[item.type:upper()] or ''
    if icon ~= '' then icon = icon .. ' ' end

    local location
    if item.valid ~= 1 then
      location = ''
    elseif item.module ~= '' then
      location = item.module
    elseif item.bufnr <= 0 then
      location = '[No Name]'
    else
      location = ('%s:%d'):format(
        vim.fn.fnamemodify(vim.fn.bufname(item.bufnr), ':p:~:.'),
        item.lnum
      )
    end
    if location ~= '' then location = location .. '│' end

    local line = location .. icon .. item.text:gsub('\n', ' ')
    if line == '' then line = ' ' end

    lines[#lines + 1] = line
  end

  return lines
end
