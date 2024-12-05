vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require 'faergeek.config.status'
require 'faergeek.config.spell'
require 'faergeek.config.options'
require 'faergeek.config.keymaps'
require 'faergeek.config.autocmds'
require 'faergeek.config.sessions'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('faergeek.plugins', {
  change_detection = {
    notify = false,
  },
  pkg = {
    sources = {
      'lazy',
      'packspec',
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'spellfile',
        'tarPlugin',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
