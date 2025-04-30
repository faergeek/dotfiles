return {
  {
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-rhubarb',
    },
    cmd = {
      'G',
      'GBrowse',
      'GDelete',
      'GMove',
      'GRemove',
      'GRename',
      'GUnlink',
      'Gcd',
      'Gclog',
      'Gdiffsplit',
      'Gdrop',
      'Gedit',
      'Ggrep',
      'Ghdiffsplit',
      'Git',
      'Glcd',
      'Glgrep',
      'Gllog',
      'Gpedit',
      'Gread',
      'Gsplit',
      'Gtabedit',
      'Gvdiffsplit',
      'Gvsplit',
      'Gwq',
      'Gwrite',
    },
    keys = {
      {
        desc = 'Git: Status',
        '<leader>gs',
        '<Cmd>Git<CR>',
      },
      {
        desc = 'Git: Blame',
        mode = { 'n', 'x' },
        '<leader>gb',
        ':Git blame -w --date=short-local<CR>',
        silent = true,
      },
      {
        desc = 'Git: Diff',
        '<leader>gd',
        '<Cmd>Gvdiffsplit<CR>',
      },
      {
        desc = 'Git: File Log',
        '<leader>gfl',
        '<Cmd>Git log %<CR>',
      },
      {
        desc = 'Git: Log',
        '<leader>gl',
        '<Cmd>Git log<CR>',
      },
      {
        desc = 'Git: Log',
        mode = { 'x' },
        expr = true,
        silent = true,
        '<leader>gl',
        '":Git log -L" . line("v") . "," . line(".") . ":" . "%<CR>"',
      },
      {
        desc = 'Git: External',
        mode = { 'n', 'x' },
        '<leader>gx',
        ':GBrowse<CR>',
        silent = true,
      },
      {
        desc = 'Git: Yank External URL',
        mode = { 'n', 'x' },
        '<leader>gy',
        ':GBrowse!<CR>',
        silent = true,
      },
      {
        'q',
        'gq',
        ft = { 'fugitive', 'fugitiveblame' },
        remap = true,
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    keys = {
      {
        desc = 'Next change',
        mode = { 'n', 'x' },
        expr = true,
        ']c',
        function()
          return vim.wo.diff and ']c' or '<Cmd>Gitsigns nav_hunk next<CR>'
        end,
      },
      {
        desc = 'Previous change',
        mode = { 'n', 'x' },
        expr = true,
        '[c',
        function()
          return vim.wo.diff and '[c' or '<Cmd>Gitsigns nav_hunk prev<CR>'
        end,
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
        '<leader>hu',
        '<Cmd>Gitsigns undo_stage_hunk<CR>',
      },
      {
        desc = 'Stage Buffer',
        '<leader>hS',
        '<Cmd>Gitsigns stage_buffer<CR>',
      },
      {
        desc = 'Reset Buffer',
        '<leader>hR',
        '<Cmd>Gitsigns reset_buffer<CR>',
      },
      {
        desc = 'Hunk Preview',
        '<leader>hp',
        '<Cmd>Gitsigns preview_hunk<CR>',
      },
      {
        desc = 'Hunk Inline Preview',
        '<leader>hi',
        '<Cmd>Gitsigns preview_hunk_inline<CR>',
      },
    },
    opts = {
      attach_to_untracked = true,
      current_line_blame = true,
      current_line_blame_opts = {
        ignore_whitespace = true,
      },
    },
  },
}
