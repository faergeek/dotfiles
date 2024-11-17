return {
  {
    'antoinemadec/FixCursorHold.nvim',
    init = function() vim.g.cursorhold_updatetime = 100 end,
  },
  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  { 'antonk52/vim-browserslist', ft = 'browserslist' },
  {
    'nvim-lua/plenary.nvim',
    dependencies = { 'antonk52/vim-browserslist' },
    lazy = true,
    config = function()
      require('plenary.filetype').add_file 'browserslist'
      require('plenary.filetype').add_file 'glsl'
    end,
  },
  { 'fladson/vim-kitty', ft = 'kitty' },
}
