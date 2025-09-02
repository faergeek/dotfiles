return {
  {
    'L3MON4D3/LuaSnip',
    version = '2.*',
    build = 'make install_jsregexp',
    lazy = true,
    opts = {
      update_events = { 'TextChanged', 'TextChangedI' },
    },
    config = function(_, opts)
      local ls = require 'luasnip'

      ls.setup(opts)

      ls.filetype_extend('javascriptreact', { 'javascript' })
      ls.filetype_extend('typescript', { 'javascript' })

      ls.filetype_extend(
        'typescriptreact',
        { 'javascript', 'javascriptreact', 'typescript' }
      )

      require('luasnip.loaders.from_lua').lazy_load()
    end,
  },
  { 'saghen/blink.compat', version = '*', lazy = true, opts = {} },
  { 'rcarriga/cmp-dap', lazy = true },
  {
    'saghen/blink.cmp',
    version = '*',
    event = 'InsertEnter',
    dependencies = { 'L3MON4D3/LuaSnip' },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      cmdline = {
        enabled = false,
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = false,
          },
          create_undo_point = false,
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
        },
        ghost_text = {
          enabled = true,
        },
      },
      signature = {
        enabled = true,
        window = {
          show_documentation = true,
        },
      },
      snippets = { preset = 'luasnip' },
      sources = {
        per_filetype = {
          ['dap-repl'] = { 'dap' },
          lua = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
          sql = { 'dadbod', 'snippets', 'buffer' },
        },
        providers = {
          dadbod = {
            name = 'Dadbod',
            module = 'vim_dadbod_completion.blink',
          },
          dap = {
            name = 'dap',
            module = 'blink.compat.source',
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
          path = {
            opts = {
              show_hidden_files_by_default = true,
            },
          },
        },
      },
    },
  },
  {
    'kristijanhusak/vim-dadbod-completion',
    dependencies = { 'tpope/vim-dadbod' },
    lazy = true,
  },
}
