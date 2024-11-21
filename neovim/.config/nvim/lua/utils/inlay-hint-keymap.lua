local autocmd = require('utils').autocmd

---@type number|nil
local inlay_hint_autocmd_id

---@param enable boolean|nil
local function toggle_inlay_hint(enable)
  local enabled = vim.lsp.inlay_hint.is_enabled()
  if enable == nil then enable = not enabled end

  if enable ~= enabled then vim.lsp.inlay_hint.enable(enable) end

  ---@type boolean
  local autocmd_exists = inlay_hint_autocmd_id ~= nil
  if enable ~= autocmd_exists then
    if inlay_hint_autocmd_id then
      vim.api.nvim_del_autocmd(inlay_hint_autocmd_id)
      inlay_hint_autocmd_id = nil
    else
      inlay_hint_autocmd_id = autocmd(
        'Hide inlay hints once cursor is moved',
        'CursorMoved',
        function() toggle_inlay_hint(false) end,
        { once = true }
      )
    end
  end
end

return function() toggle_inlay_hint() end
