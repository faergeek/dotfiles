return {
  {
    'folke/neoconf.nvim',
    dependencies = { 'faergeek/neomakery.nvim' },
    cmd = 'Neoconf',
    opts = {},
    config = function(_, opts)
      require('neoconf').setup(opts)

      require('neoconf.plugins').register {
        name = 'dap-debuggers',
        on_schema = function(schema)
          schema:set('debuggers', {
            type = 'array',
            items = {
              type = 'object',
              required = { 'name', 'request', 'type' },
              oneOf = {
                {
                  additionalProperties = false,
                  properties = {
                    name = {
                      type = 'string',
                      default = 'Firefox',
                    },
                    pathMappings = {
                      description = 'Additional mappings from URLs (as seen by Firefox) to filesystem paths (as seen by VS Code)',
                      type = 'array',
                      items = {
                        type = 'object',
                        properties = {
                          url = {
                            description = 'The URL as seen by Firefox',
                            type = 'string',
                          },
                          path = {
                            description = 'The corresponding filesystem path as seen by VS Code',
                            type = {
                              'string',
                              'null',
                            },
                          },
                        },
                      },
                    },
                    request = { enum = { 'attach' } },
                    skipFiles = {
                      type = 'array',
                      description = 'An array of glob patterns to skip when debugging',
                      items = {
                        type = 'string',
                      },
                      default = { '${workspaceFolder}/node_modules/**/*' },
                    },
                    type = {
                      enum = { 'firefox' },
                    },
                    url = {
                      type = 'string',
                      default = 'http://localhost:8080',
                    },
                    webRoot = {
                      type = 'string',
                      default = '${workspaceFolder}',
                    },
                  },
                },
                {
                  additionalProperties = false,
                  properties = {
                    cwd = { type = 'string', default = '${workspaceFolder}' },
                    localRoot = {
                      type = 'string',
                      default = '${workspaceFolder}',
                    },
                    name = {
                      type = 'string',
                      default = 'Node',
                    },
                    port = { type = 'number', default = 9229 },
                    remoteRoot = {
                      type = 'string',
                      default = '${workspaceFolder}',
                    },
                    request = { enum = { 'attach' } },
                    type = { enum = { 'pwa-node' } },
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
    cmd = {
      'AbortDispatch',
      'Copen',
      'Dispatch',
      'FocusDispatch',
      'Make',
      'Spawn',
      'Start',
    },
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
