require 'faergeek.config.status'
require 'faergeek.config.options'

vim.keymap.set({ 'n', 'x' }, 'k', "v:count ? 'k' : 'gk'", { expr = true })
vim.keymap.set({ 'n', 'x' }, 'j', "v:count ? 'j' : 'gj'", { expr = true })

vim.api.nvim_create_autocmd(
  'TextYankPost',
  { callback = function() vim.hl.on_yank {} end }
)

vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(event)
    if vim.bo.buftype == 'help' then
      vim.opt_local.signcolumn = 'auto'
      vim.keymap.set('n', 'q', '<Cmd>q<CR>', { buffer = event.buf })
    end
  end,
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = {
    'caddbuffer',
    'caddexpr',
    'caddfile',
    'cbuffer',
    'cexpr',
    'cfile',
    'cgetbuffer',
    'cgetexpr',
    'cgetfile',
    'make',
  },
  callback = function(event)
    local ns = vim.api.nvim_create_namespace 'QuickFixCmdPost'
    vim.diagnostic.reset(ns)

    local qf = vim.fn.getqflist { items = 0, title = 0 }

    ---@type table<integer, vim.Diagnostic[]>
    local per_buffer = {}
    for _, item in ipairs(vim.diagnostic.fromqflist(qf.items)) do
      per_buffer[item.bufnr] = per_buffer[item.bufnr] or {}
      item.source = event.match
      table.insert(per_buffer[item.bufnr], item)
    end

    ---@param bufnr integer
    ---@param fn fun()
    local function once_loaded(bufnr, fn)
      if vim.api.nvim_buf_is_loaded(bufnr) then
        fn()
      else
        vim.api.nvim_create_autocmd('BufRead', {
          buffer = bufnr,
          callback = function() fn() end,
          once = true,
        })
      end
    end

    for bufnr, diagnostics in pairs(per_buffer) do
      once_loaded(
        bufnr,
        function() vim.diagnostic.set(ns, bufnr, diagnostics) end
      )
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
