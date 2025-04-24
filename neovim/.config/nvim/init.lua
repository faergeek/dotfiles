require 'faergeek.config.status'
require 'faergeek.config.options'

vim.keymap.set({ 'n', 'x' }, 'k', "v:count ? 'k' : 'gk'", { expr = true })
vim.keymap.set({ 'n', 'x' }, 'j', "v:count ? 'j' : 'gj'", { expr = true })

vim.api.nvim_create_autocmd(
  'TextYankPost',
  { callback = function() vim.hl.on_yank {} end }
)

vim.api.nvim_create_autocmd('StdinReadPost', {
  callback = function(event)
    local term_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(0, term_buf)

    vim.opt_local.list = false
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
    vim.opt_local.signcolumn = 'no'

    vim.api.nvim_chan_send(
      vim.api.nvim_open_term(term_buf, {}),
      table.concat(vim.api.nvim_buf_get_lines(event.buf, 0, -1, false), '\r\n')
    )

    vim.api.nvim_buf_delete(event.buf, { force = true })

    vim.keymap.set('n', 'q', '<Cmd>q<CR>', { buffer = term_buf })
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(event)
    if vim.bo.buftype == 'help' then
      vim.opt_local.signcolumn = 'auto'
      vim.keymap.set('n', 'q', '<Cmd>q<CR>', { buffer = event.buf })
    end
  end,
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
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
