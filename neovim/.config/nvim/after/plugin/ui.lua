local keymap = require('faergeek.utils').keymap

require('rose-pine').setup {
  disable_background = true,
  disable_float_background = true,
}

vim.cmd.colorscheme 'rose-pine'

require('lualine').setup {
  options = {
    globalstatus = true,
    theme = 'rose-pine',
  },
  sections = {
    lualine_a = {
      require('auto-session-library').current_session_name,
      { 'mode' },
    },
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

require('hlslens').setup {
  calm_down = true,
}

keymap(
  'Search: Next item',
  'n',
  'n',
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  {
    silent = true,
  }
)

keymap(
  'Search: Prev item',
  'n',
  'N',
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  {
    silent = true,
  }
)

keymap(
  'Search for word under cursor',
  'n',
  '*',
  [[*<Cmd>lua require('hlslens').start()<CR>]],
  {
    silent = true,
  }
)

keymap(
  'Search backwards for word under cursor',
  'n',
  '#',
  [[#<Cmd>lua require('hlslens').start()<CR>]],
  {
    silent = true,
  }
)

keymap(
  'Go to next occurence of word under cursor',
  'n',
  'g*',
  [[g*<Cmd>lua require('hlslens').start()<CR>]],
  {
    silent = true,
  }
)

keymap(
  'Go to prev occurence of word under cursor',
  'n',
  'g#',
  [[g#<Cmd>lua require('hlslens').start()<CR>]],
  {
    silent = true,
  }
)

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
