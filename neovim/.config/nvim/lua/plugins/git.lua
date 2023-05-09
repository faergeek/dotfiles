return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    keys = {
      {
        desc = 'Git: Next hunk',
        mode = { 'n', 'v' },
        ']c',
        function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() require('gitsigns').next_hunk() end)
          return '<Ignore>'
        end,
      },
      {
        desc = 'Git: Previous hunk',
        mode = { 'n', 'v' },
        '[c',
        function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() require('gitsigns').prev_hunk() end)
          return '<Ignore>'
        end,
      },
      {
        desc = 'Git: [H]unk [S]tage',
        '<leader>hs',
        function() require('gitsigns').stage_hunk() end,
      },
      {
        desc = 'Git: [H]unk [S]tage',
        mode = 'v',
        '<leader>hs',
        function()
          require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end,
      },
      {
        desc = 'Git: [H]unk [R]eset',
        '<leader>hr',
        function() require('gitsigns').reset_hunk() end,
      },
      {
        desc = 'Git: [H]unk [R]eset',
        mode = 'v',
        '<leader>hr',
        function()
          require('gitsigns').reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end,
      },
      {
        desc = 'Git: Undo stage hunk',
        '<leader>hu',
        function() require('gitsigns').undo_stage_hunk() end,
      },
      {
        desc = 'Git: Stage buffer',
        '<leader>hS',
        function() require('gitsigns').stage_buffer() end,
      },
      {
        desc = 'Git: Reset buffer',
        '<leader>hR',
        function() require('gitsigns').reset_buffer() end,
      },
      {
        desc = 'Git: Preview hunk',
        '<leader>hp',
        function() require('gitsigns').preview_hunk() end,
      },
      {
        desc = 'Git: Blame line',
        '<leader>gb',
        function() require('gitsigns').blame_line { full = true } end,
      },
    },
    opts = {
      trouble = false,
    },
  },
}
