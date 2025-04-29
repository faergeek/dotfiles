return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      bigfile = {
        notify = false,
      },
      quickfile = {},
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
