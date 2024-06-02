return {
  {
    'folke/neoconf.nvim',
    dependencies = { 'faergeek/neomakery.nvim' },
    cmd = 'Neoconf',
    opts = {},
    config = function(_, opts)
      require('neoconf').setup(opts)

      local name = 'dap'

      require('neoconf.plugins').register {
        name = name,
        on_schema = function(schema)
          schema:set(name, {
            type = 'object',
            properties = {
              firefox = {
                type = 'object',
                properties = {
                  url = {
                    type = 'string',
                    default = 'http://localhost:8080',
                  },
                  webRoot = {
                    type = 'string',
                    default = '${workspaceFolder}',
                  },
                },
                required = { 'url', 'webRoot' },
              },
              node = {
                type = 'object',
                properties = {
                  cwd = {
                    type = 'string',
                    default = '${workspaceFolder}',
                  },
                  localRoot = {
                    type = 'string',
                    default = '${workspaceFolder}',
                  },
                  port = {
                    type = 'number',
                    default = 9229,
                  },
                  remoteRoot = {
                    type = 'string',
                    default = '${workspaceFolder}',
                  },
                },
              },
            },
          })
        end,
      }
    end,
  },
  {
    'tpope/vim-dispatch',
    cmd = { 'Dispatch', 'Make' },
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
