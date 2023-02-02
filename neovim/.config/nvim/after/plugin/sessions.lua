local keymap = require('faergeek.utils').keymap
local extensions = require('telescope').extensions

require('nvim-lastplace').setup {
  lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
  lastplace_ignore_filetype = { 'gitcommit', 'gitrebase' },
  lastplace_open_folds = true,
}

require('auto-session').setup {
  auto_session_create_enabled = false,
  auto_session_use_git_branch = true,
  log_level = 'error',
}

require('session-lens').setup {}
require('telescope').load_extension 'session-lens'

keymap(
  'Telescope [F]ind [S]essions',
  'n',
  '<leader>fs',
  extensions['session-lens'].search_session
)

require('exrc').setup {
  files = {
    '.nvim.lua',
  },
}
