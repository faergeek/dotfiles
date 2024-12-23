-- work around 0.10.3 issue with `:Inspect`
-- https://github.com/neovim/neovim/issues/31675#issuecomment-2558405042
vim.hl = vim.highlight

require 'faergeek.config.status'
require 'faergeek.config.spell'
require 'faergeek.config.options'
require 'faergeek.config.keymaps'
require 'faergeek.config.autocmds'
require 'faergeek.config.sessions'
require 'faergeek.config.lazy'
