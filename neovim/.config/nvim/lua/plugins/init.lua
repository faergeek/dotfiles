return {
  {
    'antoinemadec/FixCursorHold.nvim',
    init = function() vim.g.cursorhold_updatetime = 100 end,
  },
  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  { 'browserslist/vim-browserslist', ft = 'browserslist' },
  { 'fladson/vim-kitty', ft = 'kitty' },
  { 'nvim-lua/plenary.nvim', lazy = true },
}
