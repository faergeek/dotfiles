vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.cmd('silent mkspell! ' .. vim.fn.stdpath 'config' .. '/spell/en.utf-8.add')

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.sessions'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
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
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
