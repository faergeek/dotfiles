return {
  {
    'folke/neoconf.nvim',
    cmd = 'Neoconf',
    dependencies = {
      {
        'faergeek/neomakery.nvim',
        keys = {
          {
            desc = 'Neomakery: [M]ake',
            '<leader>m',
            function() require('neomakery').show_menu() end,
          },
        },
      },
    },
    opts = {},
  },
}
