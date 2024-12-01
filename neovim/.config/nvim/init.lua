vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require 'config.status'
require 'config.spell'
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.sessions'

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

require('lazy').setup('plugins', {
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
