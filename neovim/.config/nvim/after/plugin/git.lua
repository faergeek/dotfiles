require('gitsigns').setup {
  on_attach = function(bufnr)
    local keymap = require('faergeek.utils').keymap
    local gitsigns = require 'gitsigns'

    keymap('Git: Next hunk', 'n', ']c', function()
      if vim.wo.diff then
        return ']c'
      end

      vim.schedule(function()
        gitsigns.next_hunk()
      end)
      return '<Ignore>'
    end, {
      buffer = bufnr,
      expr = true,
    })

    keymap('Git: Previous hunk', 'n', '[c', function()
      if vim.wo.diff then
        return '[c'
      end

      vim.schedule(function()
        gitsigns.prev_hunk()
      end)
      return '<Ignore>'
    end, {
      buffer = bufnr,
      expr = true,
    })

    keymap(
      'Git: Stage hunk',
      { 'n', 'v' },
      '<leader>hs',
      ':Gitsigns stage_hunk<CR>',
      { buffer = bufnr }
    )

    keymap(
      'Git: Reset hunk',
      { 'n', 'v' },
      '<leader>hr',
      ':Gitsigns reset_hunk<CR>',
      { buffer = bufnr }
    )

    keymap(
      'Git: Stage buffer',
      'n',
      '<leader>hS',
      gitsigns.stage_buffer,
      { buffer = bufnr }
    )

    keymap(
      'Git: Undo stage hunk',
      'n',
      '<leader>hu',
      gitsigns.undo_stage_hunk,
      { buffer = bufnr }
    )

    keymap(
      'Git: Reset buffer',
      'n',
      '<leader>hR',
      gitsigns.reset_buffer,
      { buffer = bufnr }
    )

    keymap(
      'Git: Preview hunk',
      'n',
      '<leader>hp',
      gitsigns.preview_hunk,
      { buffer = bufnr }
    )

    keymap('Git: Blame line', 'n', '<leader>hb', function()
      gitsigns.blame_line { full = true }
    end, { buffer = bufnr })

    keymap(
      'Git: Toggle current line blame',
      'n',
      '<leader>tb',
      gitsigns.toggle_current_line_blame,
      { buffer = bufnr }
    )

    keymap(
      'Git: Diff',
      'n',
      '<leader>hd',
      gitsigns.diffthis,
      { buffer = bufnr }
    )

    keymap(
      '[G]it: Toggle [D]eleted',
      'n',
      '<leader>gd',
      gitsigns.toggle_deleted,
      { buffer = bufnr }
    )

    keymap(
      'Git: Select [i]n [h]unk',
      { 'o', 'x' },
      'ih',
      ':<C-U>Gitsigns select_hunk<CR>',
      { buffer = bufnr }
    )
  end,
}
