return {
  {
    'folke/neoconf.nvim',
    cmd = 'Neoconf',
    opts = {
      plugins = {
        jsonls = {
          configured_servers_only = false,
        },
      },
    },
  },
  'tpope/vim-dispatch',
  {
    'rmagatti/auto-session',
    lazy = false,
    keys = {
      {
        desc = 'Session: Delete',
        '<leader>sd',
        '<Cmd>Autosession delete<CR>',
      },
    },
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      args_allow_single_directory = false,
      auto_create = false,
      use_git_branch = true,
    },
  },
}
