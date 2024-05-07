return {
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = { 'tpope/vim-dadbod' },
    cmd = {
      'DBUI',
      'DBUIClose',
      'DBUIToggle',
      'DBUIFindBuffer',
      'DBUIRenameBuffer',
      'DBUIAddConnection',
      'DBUILastQueryInfo',
    },
    keys = {
      {
        desc = 'DBUI: Toggle',
        '<BS>',
        '<Cmd>DBUIToggle<CR>',
      },
    },
    init = function()
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_force_echo_notifications = 1
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_win_position = 'right'
    end,
  },
  {
    'kristijanhusak/vim-dadbod-completion',
    dependencies = { 'tpope/vim-dadbod' },
    ft = { 'sql', 'mysql', 'plsql' },
    config = function()
      require('cmp').setup.filetype({ 'sql', 'mysql', 'plsql' }, {
        sources = { { name = 'vim-dadbod-completion' } },
      })
    end,
  },
}
