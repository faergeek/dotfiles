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

local function get_diagnostic_for_cursor()
  local cursor_col = vim.api.nvim_win_get_cursor(0)[2]

  for _, diagnostic in
    ipairs(vim.diagnostic.get(0, { lnum = vim.fn.line '.' - 1 }))
  do
    if (cursor_col >= diagnostic.col) and (cursor_col < diagnostic.end_col) then
      return diagnostic
    end
  end

  return error()
end

local diagnostic_severity_suffixes = { 'Error', 'Warn', 'Info', 'Hint' }

local function get_diagnostic_color(diagnostic)
  return 'Diagnostic' .. diagnostic_severity_suffixes[diagnostic.severity]
end

local function get_diagnostic_sign(diagnostic)
  local defined_sign = vim.fn.sign_getdefined(
    'DiagnosticSign' .. diagnostic_severity_suffixes[diagnostic.severity]
  )[1]

  if defined_sign then
    return defined_sign.text
  else
    return ''
  end
end

local function format_diagnostic_verbose(diagnostic)
  return string.format(
    '%s%s [%s]',
    get_diagnostic_sign(diagnostic),
    diagnostic.message,
    diagnostic.source
  )
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
    lualine_b = {
      {
        'b:gitsigns_head',
        icon = '',
      },
    },
    lualine_c = {
      {
        function()
          return format_diagnostic_verbose(get_diagnostic_for_cursor())
        end,

        color = function()
          local _, diagnostic = pcall(get_diagnostic_for_cursor)

          if diagnostic then
            return get_diagnostic_color(diagnostic)
          else
            return nil
          end
        end,
      },
    },
    lualine_x = {
      'searchcount',
      'encoding',
      'fileformat',
      'filetype',
    },
  },
  tabline = {
    lualine_a = { require('auto-session-library').current_session_name },
    lualine_x = { require('tabline').tabline_tabs },
  },
  winbar = {
    lualine_c = {
      {
        'filename',
        newfile_status = true,
        path = 1,
        symbols = {
          modified = '',
        },
      },
    },
    lualine_x = {
      { 'diff', source = lualine_diff_source },
      { 'diagnostics' },
    },
  },
  inactive_winbar = {
    lualine_c = {
      {
        'filename',
        newfile_status = true,
        path = 1,
        symbols = {
          modified = '',
        },
      },
    },
    lualine_x = {
      { 'diff', source = lualine_diff_source },
      { 'diagnostics' },
    },
  },
}

require('buffer_manager').setup {
  focus_alternate_buffer = true,
}

local buffer_keys = '1234567890'
for i = 1, #buffer_keys do
  local key = buffer_keys:sub(i, i)
  keymap(
    string.format('Buffer Manager: switch to buffer #%s', key),
    'n',
    string.format('<leader>%s', key),
    function()
      require('buffer_manager.ui').nav_file(i)
    end
  )
end

keymap('Buffer Manager: [O]pen buffers', 'n', '<leader>o', function()
  require('buffer_manager.ui').toggle_quick_menu()
end)

require('tabline').setup {
  enable = false,
  options = {
    show_bufnr = true,
  },
}

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
    relative = 'editor',
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
  float = {
    border = 'single',
    format = format_diagnostic_verbose,
    scope = 'cursor',
  },
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
