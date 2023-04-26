require('guess-indent').setup()

require('nvim-treesitter.configs').setup {
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  endwise = {
    enable = true,
  },
  ensure_installed = {
    'bash',
    'c',
    'comment',
    'css',
    'diff',
    'dockerfile',
    'fish',
    'git_rebase',
    'gitcommit',
    'gitignore',
    'glsl',
    'help',
    'html',
    'javascript',
    'json5',
    'lua',
    'markdown',
    'markdown_inline',
    'ocaml',
    'ocaml_interface',
    'proto',
    'query',
    'rust',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml',
    'zig',
  },
  highlight = {
    additional_vim_regex_highlighting = false,
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  indent = { enable = true },
}

require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

require('nvim-autopairs').setup {
  break_undo = false,
  check_ts = true,
}

require('mini.surround').setup {}

require('colorizer').setup {
  user_default_options = {
    mode = 'virtualtext',
    RRGGBBAA = true,
    AARRGGBB = true,
    rgb_fn = true,
    hsl_fn = true,
  },
}
