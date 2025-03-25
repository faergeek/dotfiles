return {
  {
    'saghen/blink.cmp',
    version = '*',
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
      keymap = {
        ['<C-space>'] = { 'show' },
        ['<C-e>'] = { 'hide' },
        ['<C-y>'] = { 'accept' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-f>'] = { 'snippet_forward' },
        ['<C-b>'] = { 'snippet_backward' },
      },
      signature = {
        enabled = true,
        window = {
          show_documentation = true,
        },
      },
      sources = {
        per_filetype = {
          lua = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
          sql = { 'dadbod', 'snippets', 'buffer' },
        },
        providers = {
          dadbod = {
            name = 'Dadbod',
            module = 'vim_dadbod_completion.blink',
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
    dependencies = { 'tpope/vim-dadbod', 'saghen/blink.cmp' },
    ft = { 'sql', 'mysql', 'plsql' },
  },
}
