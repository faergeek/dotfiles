local widgets = require 'dap.ui.widgets'

local M = {}

M.frames_sidebar = widgets.sidebar(widgets.frames, {
  winfixwidth = true,
  wrap = false,
})

M.scopes_sidebar = widgets.sidebar(widgets.scopes, {
  winfixwidth = true,
  wrap = false,
})

return M
