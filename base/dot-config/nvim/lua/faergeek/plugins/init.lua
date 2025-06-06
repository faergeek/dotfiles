return {
  {
    'nvim-tree/nvim-web-devicons',
    opts = {
      default = true,
    },
  },
  {
    'tpope/vim-dispatch',
    cmd = {
      'AbortDispatch',
      'Copen',
      'Dispatch',
      'FocusDispatch',
      'Make',
      'Spawn',
      'Start',
    },
    keys = {
      'm<CR>',
      'm<Space>',
      'm!',
      'm?',
      '`<CR>',
      '`<Space>',
      '`!',
      '`?',
      "'<CR>",
      "'<Space>",
      "'!",
      "'?",
      "g'<CR>",
      "g'<Space>",
      "g'!",
      "g'?",
    },
  },
}
