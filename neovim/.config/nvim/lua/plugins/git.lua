return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    keys = {
      {
        desc = '[C]hange: Next',
        mode = { 'n', 'v' },
        ']c',
        function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() require('gitsigns').next_hunk() end)
          return '<Ignore>'
        end,
        expr = true,
      },
      {
        desc = '[C]hange: Prev',
        mode = { 'n', 'v' },
        '[c',
        function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() require('gitsigns').prev_hunk() end)
          return '<Ignore>'
        end,
        expr = true,
      },
      {
        desc = '[H]unk [S]tage',
        '<leader>hs',
        function() require('gitsigns').stage_hunk() end,
      },
      {
        desc = '[H]unk [S]tage',
        mode = 'v',
        '<leader>hs',
        function()
          require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end,
      },
      {
        desc = '[H]unk [R]eset',
        '<leader>hr',
        function() require('gitsigns').reset_hunk() end,
      },
      {
        desc = '[H]unk [R]eset',
        mode = 'v',
        '<leader>hr',
        function()
          require('gitsigns').reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end,
      },
      {
        desc = '[H]unk [U]ndo',
        '<leader>hu',
        function() require('gitsigns').undo_stage_hunk() end,
      },
      {
        desc = '[H]unks [S]tage',
        '<leader>hS',
        function() require('gitsigns').stage_buffer() end,
      },
      {
        desc = '[H]unks [R]eset',
        '<leader>hR',
        function() require('gitsigns').reset_buffer() end,
      },
      {
        desc = '[H]unk [P]review',
        '<leader>hp',
        function() require('gitsigns').preview_hunk() end,
      },
      {
        desc = '[H]unk Preview [I]nline',
        '<leader>hi',
        ':Gitsigns preview_hunk_inline<CR>',
      },
      {
        desc = '[G]it: [B]lame',
        '<leader>gb',
        function() require('gitsigns').blame_line { full = true } end,
      },
    },
    opts = {
      linehl = true,
    },
  },
}
