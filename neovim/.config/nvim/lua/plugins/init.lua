return {
  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  { 'antonk52/vim-browserslist', ft = 'browserslist' },
  { 'rescript-lang/vim-rescript', ft = 'rescript' },
  {
    'nvim-lua/plenary.nvim',
    dependencies = { 'antonk52/vim-browserslist' },
    config = function()
      require('plenary.filetype').add_file 'browserslist'
      require('plenary.filetype').add_file 'glsl'
    end,
  },
}
