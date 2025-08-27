return {
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    keys = {
      {
        'q',
        '<Cmd>q<CR>',
        ft = 'startuptime',
      },
    },
  },
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
  },
}
