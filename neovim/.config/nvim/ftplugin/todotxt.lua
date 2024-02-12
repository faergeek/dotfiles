local keymap = require('utils').keymap
local km_opts = { buffer = true }

keymap('Mark task as done', { 'n', 'x' }, '<localleader>x', function()
  local lnum = vim.fn.getpos('.')[2]

  vim.api.nvim_buf_set_text(
    0,
    lnum - 1,
    0,
    lnum - 1,
    (vim.fn.getline(lnum):match '^%(%w%)%s+' or ''):len(),
    { 'x ' .. vim.fn.strftime '%Y-%m-%d' .. ' ' }
  )
end, km_opts)

---@param new_priority string|nil
local function set_priority(new_priority)
  local lnum = vim.fn.getpos('.')[2]
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

for i = ('A'):byte(), ('Z'):byte() do
  local priority = string.char(i)

  keymap(
    'Set task priority to ' .. priority,
    'n',
    '<localleader>p' .. priority:lower(),
    function() set_priority(priority) end,
    km_opts
  )
end

keymap('Remove priority', 'n', '<localleader>p-', set_priority, km_opts)

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
