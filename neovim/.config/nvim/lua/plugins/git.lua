return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    keys = {
      {
        desc = 'Next change',
        mode = { 'n', 'x' },
        expr = true,
        silent = true,
        ']c',
        function() return vim.wo.diff and ']c' or '<Cmd>Gitsigns next_hunk<CR>' end,
      },
      {
        desc = 'Previous change',
        mode = { 'n', 'x' },
        expr = true,
        silent = true,
        '[c',
        function() return vim.wo.diff and '[c' or '<Cmd>Gitsigns prev_hunk<CR>' end,
      },
      {
        desc = 'Hunk Stage',
        mode = { 'n', 'x' },
        silent = true,
        '<leader>hs',
        ':Gitsigns stage_hunk<CR>',
      },
      {
        desc = 'Hunk Reset',
        mode = { 'n', 'x' },
        silent = true,
        '<leader>hr',
        ':Gitsigns reset_hunk<CR>',
      },
      {
        desc = 'Hunk Undo',
        silent = true,
        '<leader>hu',
        '<Cmd>Gitsigns undo_stage_hunk<CR>',
      },
      {
        desc = 'Stage Buffer',
        silent = true,
        '<leader>hS',
        '<Cmd>Gitsigns stage_buffer<CR>',
      },
      {
        desc = 'Reset Buffer',
        silent = true,
        '<leader>hR',
        '<Cmd>Gitsigns reset_buffer<CR>',
      },
      {
        desc = 'Hunk Preview',
        silent = true,
        '<leader>hp',
        '<Cmd>Gitsigns preview_hunk<CR>',
      },
    },
    opts = {
      attach_to_untracked = true,
    },
  },
  {
    'sindrets/diffview.nvim',
    cmd = {
      'DiffviewLog',
      'DiffviewOpen',
      'DiffviewClose',
      'DiffviewRefresh',
      'DiffviewFocusFiles',
      'DiffviewFileHistory',
      'DiffviewToggleFiles',
    },
    keys = {
      {
        desc = 'Git: Status',
        '<leader>gs',
        '<Cmd>DiffviewOpen<CR>',
      },
      {
        desc = 'Git: File History',
        '<leader>gfh',
        '<Cmd>DiffviewFileHistory %<CR>',
      },
      {
        desc = 'Git: History',
        '<leader>gh',
        '<Cmd>DiffviewFileHistory<CR>',
      },
      {
        desc = 'Close Diffview using q',
        ft = { 'DiffviewFiles', 'DiffviewFileHistory' },
        'q',
        '<Cmd>DiffviewClose<CR>',
      },
    },
    opts = {
      file_panel = {
        win_config = {
          position = 'bottom',
          height = 16,
        },
      },
    },
  },
}
