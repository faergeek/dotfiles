require 'faergeek.config.status'
require 'faergeek.config.options'

vim.keymap.set({ 'n', 'x' }, 'k', "v:count ? 'k' : 'gk'", { expr = true })
vim.keymap.set({ 'n', 'x' }, 'j', "v:count ? 'j' : 'gj'", { expr = true })

vim.cmd(
  'silent mkspell! ' .. vim.fn.stdpath 'config' .. '/spell' .. '/words.add'
)

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

    local qf = vim.fn.getqflist { id = 0, items = 0 }

    ---@type integer[]
    local bufnrs = {}
    for _, item in ipairs(vim.diagnostic.fromqflist(qf.items)) do
      if not vim.tbl_contains(bufnrs, item.bufnr) then
        bufnrs[#bufnrs + 1] = item.bufnr
      end
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

    for _, bufnr in ipairs(bufnrs) do
      once_loaded(bufnr, function()
        qf = vim.fn.getqflist { id = qf.id, items = 0 }

        ---@type vim.Diagnostic[]
        local diagnostics = {}
        for _, item in ipairs(vim.diagnostic.fromqflist(qf.items)) do
          if item.bufnr == bufnr then
            item.source = event.match
            diagnostics[#diagnostics + 1] = item
          end
        end

        vim.diagnostic.set(ns, bufnr, diagnostics)
      end)
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
  ui = {
    backdrop = 100,
  },
})
