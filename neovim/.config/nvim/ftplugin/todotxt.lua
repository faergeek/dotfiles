local keymap = require('faergeek.utils').keymap
local km_opts = { buffer = true }

vim.api.nvim_buf_create_user_command(0, 'SetPriority', function(args)
  local new_priority = args.fargs[1]
  local line1 = args.line1
  local line2 = args.line2

  for lnum = line1, line2 do
    local priority = vim.fn.getline(lnum):match '^%((%w)%)%s+'

    if priority then
      if new_priority then
        vim.api.nvim_buf_set_text(0, lnum - 1, 1, lnum - 1, 2, { new_priority })
      else
        vim.api.nvim_buf_set_text(0, lnum - 1, 0, lnum - 1, 4, {})
      end
    elseif new_priority then
      vim.api.nvim_buf_set_text(
        0,
        lnum - 1,
        0,
        lnum - 1,
        0,
        { '(' .. new_priority .. ') ' }
      )
    end
  end
end, {
  desc = 'Set todo item priority to a specified value',
  nargs = '?',
  range = true,
})

vim.api.nvim_buf_create_user_command(0, 'Done', function(args)
  for lnum = args.line1, args.line2 do
    vim.api.nvim_buf_set_text(
      0,
      lnum - 1,
      0,
      lnum - 1,
      (vim.fn.getline(lnum):match '^%(%w%)%s+' or ''):len(),
      { 'x ' .. vim.fn.strftime '%Y-%m-%d' .. ' ' }
    )
  end
end, {
  desc = 'Mark task as done',
  range = true,
})

for i = ('A'):byte(), ('Z'):byte() do
  local priority = string.char(i)

  keymap(
    'Set task priority to ' .. priority,
    { 'n', 'x' },
    '<localleader>p' .. priority:lower(),
    ':SetPriority ' .. priority .. '<CR>',
    km_opts
  )
end

keymap(
  'Remove priority',
  { 'n', 'x' },
  '<localleader>p-',
  ':SetPriority<CR>',
  km_opts
)

keymap(
  'Mark task as done',
  { 'n', 'x' },
  '<localleader>x',
  ':Done<CR>',
  km_opts
)

keymap('Sort tasks', 'n', '<localleader>s', ':%sort<CR>', km_opts)
keymap('Sort tasks', 'x', '<localleader>s', ':sort<CR>', km_opts)

keymap('Remove completed tasks', 'n', '<localleader>d', function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)

  for lnum = #lines, 1, -1 do
    if lines[lnum]:match '^x ' then
      vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, true, {})
    end
  end
end, km_opts)
