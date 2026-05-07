vim.keymap.set({ 'n', 'x' }, 'k', "v:count ? 'k' : 'gk'", { expr = true })
vim.keymap.set({ 'n', 'x' }, 'j', "v:count ? 'j' : 'gj'", { expr = true })

vim.keymap.set('n', '<leader>pu', function() vim.pack.update() end)

vim.keymap.set(
  'n',
  '<leader>pr',
  function()
    vim.pack.update(nil, {
      offline = true,
      target = 'lockfile',
    })
  end
)

vim.keymap.set('n', '<leader>m', '<Cmd>Mason<CR>')

vim.keymap.set('n', '<BS>', '<Cmd>DBUIToggle<CR>')

vim.keymap.set('n', '<leader>fb', function() Snacks.picker() end)

vim.keymap.set(
  'n',
  '<leader>fo',
  function()
    Snacks.picker.recent {
      filter = { cwd = true },
      layout = {
        layout = { position = 'bottom' },
        preset = 'ivy',
        preview = 'main',
      },
    }
  end
)

vim.keymap.set(
  'n',
  '<leader>ff',
  function()
    Snacks.picker.files {
      cmd = 'rg',
      layout = {
        layout = { position = 'bottom' },
        preset = 'ivy',
        preview = 'main',
      },
    }
  end
)

vim.keymap.set(
  'n',
  '<leader>fg',
  function()
    Snacks.picker.grep {
      hidden = true,
      layout = {
        layout = { position = 'bottom' },
        preset = 'ivy',
        preview = 'main',
      },
    }
  end
)

vim.keymap.set(
  'n',
  '<leader>fs',
  function()
    Snacks.picker.lsp_workspace_symbols {
      layout = {
        layout = { position = 'bottom' },
        preset = 'ivy',
        preview = 'main',
      },
    }
  end
)

vim.keymap.set(
  'n',
  '<leader>fh',
  function()
    Snacks.picker.help {
      layout = {
        layout = { position = 'bottom' },
        preset = 'ivy',
      },
    }
  end
)

vim.keymap.set(
  'n',
  '<leader>fm',
  function()
    Snacks.picker.man {
      layout = {
        layout = { position = 'bottom' },
        preset = 'ivy',
      },
    }
  end
)

vim.keymap.set('n', '<leader>fc', function() Snacks.picker.commands() end)
vim.keymap.set('n', '<leader>fk', function() Snacks.picker.keymaps() end)

vim.keymap.set('n', '<leader>sr', function() require('persistence').load() end)

vim.keymap.set(
  'n',
  ']r',
  function() require('illuminate').goto_next_reference() end
)

vim.keymap.set(
  'n',
  '[r',
  function() require('illuminate').goto_prev_reference() end
)

vim.keymap.set('n', '-', '<Cmd>Oil<CR>')

vim.keymap.set(
  'n',
  '<leader>o',
  function() require('buffer_manager.ui').toggle_quick_menu() end
)

vim.keymap.set('n', '<leader>j', '<Cmd>TSJToggle<CR>')

vim.keymap.set(
  { 'n', 'x' },
  ']c',
  function() return vim.wo.diff and ']c' or '<Cmd>Gitsigns nav_hunk next<CR>' end,
  { expr = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '[c',
  function() return vim.wo.diff and '[c' or '<Cmd>Gitsigns nav_hunk prev<CR>' end,
  { expr = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>hs',
  ':Gitsigns stage_hunk<CR>',
  { silent = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>hr',
  ':Gitsigns reset_hunk<CR>',
  { silent = true }
)

vim.keymap.set('n', '<leader>hu', '<Cmd>Gitsigns undo_stage_hunk<CR>')
vim.keymap.set('n', '<leader>hS', '<Cmd>Gitsigns stage_buffer<CR>')
vim.keymap.set('n', '<leader>hR', '<Cmd>Gitsigns reset_buffer<CR>')
vim.keymap.set('n', '<leader>hp', '<Cmd>Gitsigns preview_hunk<CR>')

vim.keymap.set('n', '<leader>gs', '<Cmd>Git<CR>')

vim.keymap.set(
  { 'n', 'x' },
  '<leader>gb',
  ':Git blame -w --date=short-local<CR>',
  { silent = true }
)

vim.keymap.set('n', '<leader>gfl', '<Cmd>Git log %<CR>')
vim.keymap.set('n', '<leader>gl', '<Cmd>Git log<CR>')

vim.keymap.set(
  'x',
  '<leader>gl',
  '":Git log -L" . line("v") . "," . line(".") . ":" . "%<CR>"',
  { expr = true, silent = true }
)

vim.keymap.set({ 'n', 'x' }, '<leader>gx', ':GBrowse<CR>', { silent = true })
vim.keymap.set({ 'n', 'x' }, '<leader>gy', ':GBrowse!<CR>', { silent = true })

vim.keymap.set('n', '<leader>db', '<Cmd>DapToggleBreakpoint<CR>')

vim.keymap.set('n', '<leader>dB', function()
  vim.ui.input({ prompt = 'Breakpoint condition: ' }, function(condition)
    if not condition or condition == '' then return end

    require('dap').set_breakpoint(condition)
  end)
end)

vim.keymap.set('n', '<leader>dl', function()
  vim.ui.input({ prompt = 'Log point message: ' }, function(message)
    if not message or message == '' then return end

    require('dap').set_breakpoint(nil, nil, message)
  end)
end)

vim.keymap.set('n', '<leader>dc', '<Cmd>DapContinue<CR>')
vim.keymap.set('n', '<leader>dn', '<Cmd>DapNew<CR>')

vim.keymap.set(
  { 'n', 'x' },
  '<leader>dh',
  function() require('dap-view').hover() end
)

vim.keymap.set('n', '<leader>do', '<Cmd>DapStepOver<CR>')
vim.keymap.set('n', '<leader>di', '<Cmd>DapStepInto<CR>')
vim.keymap.set('n', '<leader>dO', '<Cmd>DapStepOut<CR>')

vim.keymap.set('n', '<leader>da', function()
  require('dap').list_breakpoints(false)
  vim.cmd 'botright cwindow'
end)

vim.keymap.set('n', '<leader>dt', '<Cmd>DapDisconnect<CR>')
