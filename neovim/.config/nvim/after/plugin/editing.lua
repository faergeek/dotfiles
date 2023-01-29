require('guess-indent').setup()

require('indent_blankline').setup {
  show_current_context = true,
}

vim.filetype.add { extension = { wgsl = 'wgsl' } }

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

parser_config.wgsl = {
  install_info = {
    url = 'https://github.com/szebniok/tree-sitter-wgsl',
    files = { 'src/parser.c' },
  },
}

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
    'comment',
    'css',
    'diff',
    'dockerfile',
    'fish',
    'git_rebase',
    'gitcommit',
    'gitignore',
    'help',
    'html',
    'javascript',
    'json5',
    'lua',
    'markdown',
    'markdown_inline',
    'proto',
    'query',
    'rust',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml',
    'wgsl',
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
  playground = {
    enable = true,
  },
}

require('treesitter-context').setup {
  patterns = {
    css = {
      'block',
    },
  },
}

require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

require('nvim-autopairs').setup {
  break_undo = false,
  check_ts = true,
}

require('colorizer').setup {}
