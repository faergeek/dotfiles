local autocmd = require('faergeek.utils').autocmd
local keymap = require('faergeek.utils').keymap

require('tokyonight').setup {
  dim_inactive = true,
  lualine_bold = true,
  sidebars = {},
}

vim.cmd.colorscheme 'tokyonight'

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
  extensions = { 'quickfix' },
  options = {
    disabled_filetypes = {
      winbar = { 'qf' },
    },
    globalstatus = true,
    theme = 'tokyonight',
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
    lualine_x = { 'searchcount', 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = { { 'diff', source = lualine_diff_source }, 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'searchcount', 'encoding', 'fileformat', 'filetype' },
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

keymap('[R]ename [T]ab', 'n', '<leader>rt', function()
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

require('trouble').setup {
  use_diagnostic_signs = true,
}

keymap('[T]rouble: Open', 'n', '<leader>to', ':Trouble<CR>')

keymap(
  '[T]rouble: Workspace [D]iagnostics',
  'n',
  '<leader>td',
  ':Trouble workspace_diagnostics<CR>'
)

keymap(
  '[T]rouble: [Q]uickfix',
  'n',
  '<leader>tq',
  ':cclose<CR>:Trouble quickfix<CR>'
)

keymap(
  '[T]rouble: LSP [R]eferences',
  'n',
  '<leader>tr',
  ':TroubleToggle lsp_references<CR>'
)

autocmd('Close trouble before vim exits', 'VimLeavePre', function()
  vim.cmd.TroubleClose()
  vim.cmd.cclose()
  vim.cmd.lclose()
end)

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

autocmd('Close terminal if job exited without an error', 'TermClose', function()
  if vim.v.event.status == 0 then
    vim.api.nvim_buf_delete(0, {})
  end
end)
