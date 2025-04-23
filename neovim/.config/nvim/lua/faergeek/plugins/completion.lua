return {
  { 'saghen/blink.compat', version = '*', lazy = true, opts = {} },
  { 'rcarriga/cmp-dap', ft = 'dap-repl' },
  {
    'saghen/blink.cmp',
    version = '*',
    dependencies = { 'ribru17/blink-cmp-spell' },
    event = { 'CmdlineEnter :', 'InsertEnter' },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
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
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'spell' },
        per_filetype = {
          ['dap-repl'] = { 'dap' },
          lua = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'spell' },
          sql = { 'dadbod', 'snippets', 'buffer', 'spell' },
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
          spell = {
            name = 'Spell',
            module = 'blink-cmp-spell',
          },
        },
      },
    },
  },
  {
    'kristijanhusak/vim-dadbod-completion',
    dependencies = { 'tpope/vim-dadbod', 'saghen/blink.cmp' },
    ft = { 'sql', 'mysql', 'plsql' },
  },
}
