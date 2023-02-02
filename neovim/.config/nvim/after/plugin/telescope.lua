local telescope = require 'telescope'
local builtin = require 'telescope.builtin'
local themes = require 'telescope.themes'

require('plenary.filetype').add_file 'browserslist'
require('plenary.filetype').add_file 'glsl'

telescope.setup {
  defaults = {
    dynamic_preview_title = true,
    layout_config = {
      width = 0.95,
      height = 0.95,
      horizontal = {
        preview_width = 0.6,
      },
    },
    path_display = { shorten = 5 },
  },
}

pcall(telescope.load_extension, 'fzf')

local keymap = require('faergeek.utils').keymap

keymap('Telescope commands', 'n', '<leader>:', builtin.commands)

keymap('Telescope search current buffer', 'n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(themes.get_ivy())
end)

keymap('Telescope git_files with find_files fallback', 'n', '<C-p>', function()
  local opts = {}

  vim.fn.system 'git rev-parse --is-inside-work-tree'

  if vim.v.shell_error == 0 then
    builtin.git_files(opts)
  else
    builtin.find_files(opts)
  end
end)

keymap('Telescope [D]ot[f]iles', 'n', '<leader>df', function()
  builtin.git_files {
    cwd = '~/dotfiles',
  }
end)

keymap('Telescope Help', 'n', '<leader>?', builtin.help_tags)
keymap('Telescope [L]ive [G]rep', 'n', '<leader>lg', builtin.live_grep)
keymap('Telescope [K]eymaps', 'n', '<leader>k', builtin.keymaps)

keymap('Telescope [G]it [B]ranches', 'n', '<leader>gb', builtin.git_branches)
keymap('Telescope [G]it [C]ommits', 'n', '<leader>gc', builtin.git_commits)
keymap('Telescope [G]it [S]tatus', 'n', '<leader>gs', builtin.git_status)
