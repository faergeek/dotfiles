require 'faergeek.config.status'
require 'faergeek.config.options'

vim.keymap.set({ 'n', 'x' }, 'k', "v:count ? 'k' : 'gk'", { expr = true })
vim.keymap.set({ 'n', 'x' }, 'j', "v:count ? 'j' : 'gj'", { expr = true })

vim.api.nvim_create_autocmd(
  'TextYankPost',
  { callback = function() vim.hl.on_yank {} end }
)

vim.api.nvim_create_autocmd('SpellFileMissing', {
  callback = function(event)
    vim.notify(
      'Downloading missing spell files for "' .. event.match .. '"...',
      vim.log.levels.INFO
    )

    for _, suffix in ipairs { 'spl', 'sug' } do
      local fname = event.match .. '.utf-8.' .. suffix

      vim.fn.system {
        'curl',
        '--fail',
        '--silent',
        '--output',
        vim.fn.stdpath 'config' .. '/spell/' .. fname,
        'https://ftp.nluug.nl/pub/vim/runtime/spell/' .. fname,
      }

      if vim.v.shell_error ~= 0 then
        vim.notify('Failed to download ' .. fname, vim.log.levels.ERROR)
      end
    end
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd(
      'silent mkspell! ' .. vim.fn.stdpath 'config' .. '/spell' .. '/words.add'
    )

    vim.opt.spell = true
    vim.opt.spellfile = vim.fn.stdpath 'config' .. '/spell/words.add'
    vim.opt.spelllang = { 'en_us', 'ru_ru' }
    vim.opt.spelloptions:append { 'camel', 'noplainbuffer' }
  end,
  nested = true,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(event)
    if vim.bo.buftype == 'help' then
      vim.opt_local.signcolumn = 'auto'
      vim.keymap.set('n', 'q', '<Cmd>q<CR>', { buffer = event.buf })
    end
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('faergeek.plugins', {
  change_detection = { notify = false },
  pkg = { sources = { 'lazy', 'packspec' } },
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
