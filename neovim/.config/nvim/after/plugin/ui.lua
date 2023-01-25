local keymap = require('faergeek.utils').keymap

require('rose-pine').setup {
  disable_background = true,
  disable_float_background = true,
}

vim.cmd.colorscheme 'rose-pine'

local function lualine_diff_source()
  local gitsigns = vim.fn.getbufvar(vim.fn.bufnr(), 'gitsigns_status_dict')

  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

require('lualine').setup {
  options = {
    globalstatus = true,
    theme = 'rose-pine',
  },
  sections = {
    lualine_a = {
      require('auto-session-library').current_session_name,
      'mode',
    },
    lualine_b = { { 'b:gitsigns_head', icon = '' } },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  winbar = {
    lualine_a = {},
    lualine_b = { { 'diff', source = lualine_diff_source }, 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = { { 'diff', source = lualine_diff_source }, 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}

require('tabline').setup {
  options = {
    show_bufnr = true,
  },
}

keymap(
  '[S]how [B]uffers',
  'n',
  '<leader>sb',
  vim.cmd.TablineToggleShowAllBuffers
)

keymap('[T]ab [R]ename', 'n', '<leader>tr', function()
  vim.ui.input({ prompt = 'Enter new tab name: ' }, function(new_name)
    if not new_name then
      return
    end

    if new_name == '' then
      vim.cmd.TablineTabRename(tostring(vim.api.nvim_get_current_tabpage()))
    else
      vim.cmd.TablineTabRename(new_name)
    end
  end)
end)

require('dressing').setup {
  input = {
    insert_only = false,
    start_in_insert = false,
  },
}

require('fidget').setup {
  text = {
    spinner = 'dots',
  },
  window = {
    blend = 0,
  },
}

local theme = require 'alpha.themes.theta'

theme.header.val = {
  '                                                     ',
  '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
  '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
  '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
  '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
  '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
  '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
  '                                                     ',
  unpack(require 'alpha.fortune'()),
}

require('alpha').setup(theme.config)

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})

vim.lsp.handlers['textDocument/signatureHelp'] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'single',
  })

vim.diagnostic.config {
  float = { border = 'single' },
}

vim.fn.sign_define('DiagnosticSignError', {
  texthl = 'DiagnosticSignError',
  text = '',
  numhl = 'DiagnosticSignError',
})

vim.fn.sign_define('DiagnosticSignWarn', {
  texthl = 'DiagnosticSignWarn',
  text = '',
  numhl = 'DiagnosticSignWarn',
})

vim.fn.sign_define('DiagnosticSignHint', {
  texthl = 'DiagnosticSignHint',
  text = '',
  numhl = 'DiagnosticSignHint',
})

vim.fn.sign_define('DiagnosticSignInfo', {
  texthl = 'DiagnosticSignInfo',
  text = '',
  numhl = 'DiagnosticSignInfo',
})

keymap('[S]how [D]iagnostics', 'n', '<leader>sd', vim.diagnostic.open_float)
keymap('Diagnostic: Next item', 'n', ']d', vim.diagnostic.goto_next)
keymap('Diagnostic: Previous item', 'n', '[d', vim.diagnostic.goto_prev)
