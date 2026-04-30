require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

require('fidget').setup {}
require('mason').setup {}

require('mason-lspconfig').setup {
  ensure_installed = {
    'bashls',
    'cssls',
    'dockerls',
    'eslint',
    'html',
    'jsonls',
    'lua_ls',
    'vtsls',
    'yamlls',
  },
}

require('blink.cmp').setup {
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
  sources = {
    per_filetype = {
      ['dap-repl'] = { 'dap' },
      lua = { inherit_defaults = true, 'lazydev' },
      sql = { 'dadbod', 'buffer' },
    },
    providers = {
      dadbod = {
        name = 'Dadbod',
        module = 'vim_dadbod_completion.blink',
      },
      dap = {
        name = 'dap',
        module = 'blink-cmp-dap',
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
}
