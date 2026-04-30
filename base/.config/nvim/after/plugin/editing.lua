require('mini.pairs').setup()

require('oil').setup {
  keymaps = {
    ['g?'] = 'actions.show_help',
    ['<CR>'] = 'actions.select',
    ['gq'] = 'actions.close',
    ['-'] = 'actions.parent',
    ['gx'] = 'actions.open_external',
  },
  lsp_file_methods = {
    autosave_changes = true,
    timeout_ms = 10000,
  },
  skip_confirm_for_simple_edits = true,
  use_default_keymaps = false,
  view_options = {
    show_hidden = true,
  },
}

require('buffer_manager').setup {
  line_keys = '',
  show_indicators = 'after',
  width = 0.9,
}

require('treesj').setup {
  max_join_length = 500,
  use_default_keymaps = false,
}

require('ts_context_commentstring').setup {
  languages = {
    c = { __default = '// %s', __multiline = '/* %s */' },
  },
}
