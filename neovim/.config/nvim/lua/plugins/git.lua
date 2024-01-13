return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    keys = {
      {
        desc = '[C]hange: Next',
        mode = { 'n', 'x' },
        expr = true,
        silent = true,
        ']c',
        function() return vim.wo.diff and ']c' or '<Cmd>Gitsigns next_hunk<CR>' end,
      },
      {
        desc = '[C]hange: Prev',
        mode = { 'n', 'x' },
        expr = true,
        silent = true,
        '[c',
        function() return vim.wo.diff and '[c' or '<Cmd>Gitsigns prev_hunk<CR>' end,
      },
      {
        desc = '[H]unk [S]tage',
        mode = { 'n', 'x' },
        silent = true,
        '<leader>hs',
        ':Gitsigns stage_hunk<CR>',
      },
      {
        desc = '[H]unk [R]eset',
        mode = { 'n', 'x' },
        silent = true,
        '<leader>hr',
        ':Gitsigns reset_hunk<CR>',
      },
      {
        desc = '[H]unk [U]ndo',
        silent = true,
        '<leader>hu',
        '<Cmd>Gitsigns undo_stage_hunk<CR>',
      },
      {
        desc = '[H]unks [S]tage',
        silent = true,
        '<leader>hS',
        '<Cmd>Gitsigns stage_buffer<CR>',
      },
      {
        desc = '[H]unks [R]eset',
        silent = true,
        '<leader>hR',
        '<Cmd>Gitsigns reset_buffer<CR>',
      },
      {
        desc = '[H]unk [P]review',
        silent = true,
        '<leader>hp',
        '<Cmd>Gitsigns preview_hunk<CR>',
      },
    },
    opts = {},
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
        desc = '[G]it: [S]tatus',
        '<leader>gs',
        '<Cmd>DiffviewOpen<CR>',
      },
      {
        desc = '[G]it: [F]ile [H]istory',
        '<leader>gfh',
        '<Cmd>DiffviewFileHistory %<CR>',
      },
      {
        desc = '[G]it: [H]istory',
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
