local autocmd = require('utils').autocmd
local buf_is_empty = require('utils').buf_is_empty

local autosave_autocmd_id = nil

local function autosave_on()
  if autosave_autocmd_id then return end

  autocmd('Close Diffview before exit', 'VimLeavePre', 'DiffviewClose')

  autosave_autocmd_id =
    autocmd('Save session before exit', 'VimLeavePre', 'SessionSave')
end

local function autosave_off()
  if not autosave_autocmd_id then return end

  vim.api.nvim_del_autocmd(autosave_autocmd_id)
  autosave_autocmd_id = nil
end

local function get_branch_name()
  local git_branch =
    vim.fn.system 'git rev-parse --abbrev-ref HEAD 2> /dev/null'

  if vim.v.shell_error ~= 0 then return nil end

  return (git_branch:gsub('\n+$', ''))
end

local function is_truthy(v) return v end

local function get_session_filenames()
  local session_filename = vim.v.this_session

  if session_filename == '' then
    local components = { vim.fn.getcwd(), get_branch_name() }

    local filename =
      table.concat(vim.tbl_filter(is_truthy, components), '@'):gsub('/', '_')

    local dirname = vim.fn.stdpath 'state' .. '/sessions/'
    vim.fn.mkdir(dirname, 'p')

    session_filename = dirname .. filename .. '.vim'
  end

  local buffers_dirname = vim.fn.stdpath 'state' .. '/buffers/'
  vim.fn.mkdir(buffers_dirname, 'p')

  local buffers_filename = buffers_dirname
    .. vim.fn.fnamemodify(session_filename, ':t:r')
    .. '.buffers'

  return {
    buffers = buffers_filename,
    session = session_filename,
  }
end

local function save_session()
  local filenames = get_session_filenames()

  vim.cmd('mksession! ' .. vim.fn.fnameescape(filenames.session))
  require('buffer_manager.ui').save_menu_to_file(filenames.buffers)
  autosave_on()
end

local function restore_session()
  local filenames = get_session_filenames()

  if vim.fn.filereadable(filenames.session) == 1 then
    vim.cmd('silent source ' .. vim.fn.fnameescape(filenames.session))
    autosave_on()
  end

  if vim.fn.filereadable(filenames.buffers) == 1 then
    require('buffer_manager.ui').load_menu_from_file(filenames.buffers)
  end
end

local function delete_session()
  autosave_off()

  local filenames = get_session_filenames()

  if vim.fn.filewritable(filenames.session) == 1 then
    vim.fn.delete(filenames.session)
  end

  if vim.fn.filewritable(filenames.buffers) == 1 then
    vim.fn.delete(filenames.buffers)
  end

  vim.v.this_session = ''
end

vim.api.nvim_create_user_command('SessionSave', save_session, {})
vim.api.nvim_create_user_command('SessionDelete', delete_session, {})

local function should_restore_session()
  if vim.fn.argc() ~= 0 then return false end

  if not buf_is_empty(0) then return false end

  for _, buf_id in pairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf_id) then return false end
  end

  for _, arg in pairs(vim.v.argv) do
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

if should_restore_session() then
  autocmd('Restore session on startup', 'VimEnter', restore_session, {
    once = true,
    nested = true,
  })
end
