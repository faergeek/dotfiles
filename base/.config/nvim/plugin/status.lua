function _G.tabline()
  ---@type string[]
  local parts = {}

  local tabnr = vim.fn.tabpagenr()
  for i = 1, vim.fn.tabpagenr '$' do
    table.insert(parts, '%' .. i .. 'T')
    table.insert(parts, i == tabnr and '%#TabLineSel#' or '%#TabLine#')
    table.insert(parts, ' 󰓩 ' .. i .. ' ')
  end

  table.insert(parts, '%#TabLineFill#')

  return table.concat(parts, '')
end

---@param bufnr integer
---@return string
function _G.oil_buf_name(bufnr)
  local dir = require('oil').get_current_dir(bufnr)

  return dir and vim.fn.fnamemodify(dir, ':p:~:.:h')
    or vim.api.nvim_buf_get_name(bufnr)
end

function _G.statusline()
  ---@type string[]
  local parts = {}

  table.insert(parts, ' 󰕰 %{winnr()} %<')
  table.insert(
    parts,
    table.concat {
      '%{',
      '% &filetype == "dbui"          ? "DBUI"',
      ': exists("b:db")               ? "%t"',
      ': &filetype == "fugitive"      ? "Git Status"',
      ': &filetype == "fugitiveblame" ? "Git Blame"',
      ': &filetype == "git"           ? "Git"',
      ': &filetype == "help"          ? "%f"',
      ': &filetype == "oil"           ? \'%{v:lua.oil_buf_name(0)}\'',
      ':                                \'%{expand("%:p:~:.") ?? "[No Name]"}\'',
      '%}',
    }
  )
  table.insert(parts, '%( %m%)')
  table.insert(parts, '%( %r%)')
  table.insert(parts, '%=')
  table.insert(
    parts,
    '%(%( %{% exists("b:db") ? "%{db_ui#statusline()}" : "" %}%)%( %q%)%( %h%)%( %w%) %) %l:%c  %P '
  )

  return table.concat(parts, '')
end
