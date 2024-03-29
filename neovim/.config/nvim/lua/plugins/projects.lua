return {
  {
    'folke/neoconf.nvim',
    dependencies = { 'faergeek/neomakery.nvim' },
    cmd = 'Neoconf',
    opts = {},
  },
  {
    'faergeek/neomakery.nvim',
    keys = {
      {
        desc = 'Neomakery: Make',
        '<leader>m',
        function() require('neomakery').show_menu() end,
      },
    },
  },
}
