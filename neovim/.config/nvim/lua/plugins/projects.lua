return {
  {
    'folke/neoconf.nvim',
    cmd = 'Neoconf',
    opts = {},
  },
  {
    'faergeek/neomakery.nvim',
    dependencies = { 'folke/neoconf.nvim' },
    keys = {
      {
        desc = 'Neomakery: Make',
        '<leader>m',
        function() require('neomakery').show_menu() end,
      },
    },
  },
}
