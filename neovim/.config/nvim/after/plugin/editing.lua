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

local ufo = require 'ufo'

ufo.setup {
  fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' ↕ %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0

    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)

      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, { chunkText, hlGroup })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)

        -- str width returned from truncate() may less than 2nd argument, need padding
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
        end

        break
      end

      curWidth = curWidth + chunkWidth
    end

    table.insert(newVirtText, { suffix, 'MoreMsg' })

    return newVirtText
  end,
}

vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
vim.keymap.set('n', 'zR', ufo.openAllFolds)

vim.keymap.set('n', 'zM', ufo.closeAllFolds)
vim.keymap.set('n', 'zm', ufo.closeFoldsWith)

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
