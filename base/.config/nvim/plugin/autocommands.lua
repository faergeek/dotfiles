vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(event)
    if vim.bo.buftype == 'help' then
      vim.opt_local.signcolumn = 'auto'
      vim.keymap.set('n', 'q', '<Cmd>q<CR>', { buffer = event.buf })
    end
  end,
})

vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'termguicolors',
  callback = function()
    if vim.o.termguicolors then
      vim.cmd.colorscheme 'catppuccin-nvim'
    else
      vim.cmd.colorscheme 'default'
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

vim.api.nvim_create_autocmd(
  'TextYankPost',
  { callback = function() vim.hl.on_yank {} end }
)
