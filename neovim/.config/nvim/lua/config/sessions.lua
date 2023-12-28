local autocmd = require('utils').autocmd

local autosave_autocmd_id = nil

local function autosave_on()
  if autosave_autocmd_id then return end

  autosave_autocmd_id =
    autocmd('Save session before exit', 'VimLeavePre', 'SessionSave')
end

local function autosave_off()
  if not autosave_autocmd_id then return end

  vim.api.nvim_del_autocmd(autosave_autocmd_id)
  autosave_autocmd_id = nil
end

local function get_session_path_base()
  local dirname = vim.fn.expand(vim.fn.stdpath 'state' .. '/sessions/')
  vim.fn.mkdir(dirname, 'p')
  return dirname .. vim.fn.getcwd():gsub('/', '%%')
end

local function get_session_filename() return get_session_path_base() .. '.vim' end
local function get_buffers_filename() return get_session_path_base() .. '.bm' end

local function save_session()
  vim.cmd('mksession! ' .. vim.fn.fnameescape(get_session_filename()))
  require('buffer_manager.ui').save_menu_to_file(get_buffers_filename())
  autosave_on()
end

local function restore_session()
  local session_filename = get_session_filename()

  if vim.fn.filereadable(session_filename) == 1 then
    vim.cmd('silent source ' .. vim.fn.fnameescape(session_filename))
    autosave_on()
  else
    require('alpha').start()
  end

  local buffers_filename = get_buffers_filename()

  if vim.fn.filereadable(buffers_filename) == 1 then
    require('buffer_manager.ui').load_menu_from_file(buffers_filename)
  end
end

local function delete_session()
  autosave_off()

  local session_filename = get_session_filename()
  if vim.fn.filewritable(session_filename) == 1 then
    vim.fn.delete(session_filename)
  end

  local buffers_filename = get_buffers_filename()
  if vim.fn.filewritable(buffers_filename) == 1 then
    vim.fn.delete(buffers_filename)
  end
end

vim.api.nvim_create_user_command('SessionSave', save_session, {})
vim.api.nvim_create_user_command('SessionDelete', delete_session, {})

local function should_restore_session_or_show_dashboard()
  if vim.fn.argc() ~= 0 then return false end

  local lines = vim.api.nvim_buf_get_lines(0, 0, 2, false)
  if #lines > 1 or (#lines == 1 and lines[1]:len() > 0) then return false end

  for _, buf_id in pairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf_id) then return false end
  end

  for _, arg in pairs(vim.v.argv) do
    if arg == '--startuptime' then return true end

    if
      arg == '-b'
      or arg == '-c'
      or vim.startswith(arg, '+')
      or arg == '-S'
    then
      return false
    end
  end

  return true
end

if should_restore_session_or_show_dashboard() then
  autocmd('Restore session on startup', 'VimEnter', restore_session, {
    once = true,
    nested = true,
  })
end
