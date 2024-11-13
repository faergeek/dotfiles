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

function _G.statusline()
  ---@type string[]
  local parts = {}

  table.insert(parts, ' 󰕰 %{winnr()} 󱔗 %n  %<')
  table.insert(
    parts,
    table.concat {
      "%{&filetype == 'alpha' ? 'Alpha'",
      ": &filetype == 'dbui' ? 'DBUI'",
      ": count(['fugitive', 'fugitiveblame', 'git'], &filetype) ? FugitiveStatusline()",
      ": &filetype == 'qf' ? w:quickfix_title",
      ": &filetype == 'oil' ? fnamemodify(v:lua.require('oil').get_current_dir(), ':p:~:.:h')",
      ": expand('%:p:~:.')",
      '}',
    }
  )
  table.insert(parts, '%( %m%)')
  table.insert(parts, '%( %r%)')
  table.insert(parts, '%=')
  table.insert(parts, '%(%( %q%)%( %h%)%( %w%) %) %l:%c  %P ')

  return table.concat(parts, '')
end
