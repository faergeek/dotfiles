return function(info)
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

  local type_to_icon = {
    E = '',
    W = '',
  }

  return vim.tbl_map(function(item)
    local fname_col = format_fname_col(item)
    local pos_col = format_pos_col(item)

    return ('%s ┃ %s ┃ %-1s %s')
      :format(
        fname_col .. string.rep(' ', fname_col_width - #fname_col),
        string.rep(' ', pos_col_width - #pos_col) .. pos_col,
        type_to_icon[item.type:upper()] or '',
        item.text:gsub('\n', ' ')
      )
      :sub(1, 1000)
  end, items)
end
