return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },
  {
    'williamboman/mason.nvim',
    cmd = {
      'Mason',
      'MasonLog',
      'MasonUpdate',
      'MasonInstall',
      'MasonUninstall',
      'MasonUninstallAll',
    },
    opts = {},
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'mason.nvim',
      'folke/neoconf.nvim',
      'b0o/schemastore.nvim',
    },
    event = { 'BufReadPre', 'BufNew', 'BufNewFile' },
    cmd = { 'LspInstall', 'LspUninstall' },
    opts = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lspconfig = require 'lspconfig'

      return {
        ensure_installed = {
          'bashls',
          'cssls',
          'dockerls',
          'eslint',
          'html',
          'jsonls',
          'lua_ls',
          'marksman',
          'vtsls',
          'yamlls',
        },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup {
              capabilities = capabilities,
            }
          end,
          cssmodules_ls = function()
            lspconfig.cssmodules_ls.setup {
              capabilities = capabilities,
              init_options = {
                camelCase = false,
              },
            }
          end,
          dockerls = function()
            lspconfig.dockerls.setup {
              capabilities,
            }
          end,
          eslint = function()
            lspconfig.eslint.setup {
              capabilities = capabilities,
              settings = {
                codeActionOnSave = { enable = true, mode = 'all' },
              },
            }
          end,
          jsonls = function()
            lspconfig.jsonls.setup {
              capabilities = capabilities,
              init_options = { provideFormatter = false },
              settings = {
                json = {
                  schemas = require('schemastore').json.schemas(),
                  validate = { enable = true },
                },
              },
            }
          end,
          lua_ls = function()
            lspconfig.lua_ls.setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  format = { enable = false },
                  workspace = { checkThirdParty = false },
                },
              },
            }
          end,
          stylelint_lsp = function()
            lspconfig.stylelint_lsp.setup {
              capabilities = capabilities,
              filetypes = { 'css' },
              settings = {
                stylelintplus = { autoFixOnFormat = true },
              },
            }
          end,
          tailwindcss = function()
            table.insert(
              lspconfig.tailwindcss.config_def.default_config.filetypes,
              'ocaml'
            )

            lspconfig.tailwindcss.setup {
              settings = {
                tailwindCSS = {
                  experimental = {
                    classRegex = {
                      {
                        '(?:clsx|cn|cva|cx)\\(([^()]*(?:\\([^)]*\\)[^()]*)*)\\)',
                        '["\'`]([^"\'`]*)["\'`]',
                      },
                      {
                        '(?:~className:\\s*)"([^"]*(?:\\([^"]*\\)[^"]*)*)"',
                        '([^"]*)',
                      },
                      {
                        '(?:~className:\\s*)\\(([^()]*(?:\\([^)]*\\)[^()]*)*)\\)',
                        '"([^"]*)"',
                      },
                    },
                  },
                },
              },
            }
          end,
          vtsls = function()
            lspconfig.vtsls.setup {
              capabilities = capabilities,
              settings = {
                javascript = {
                  preferences = {
                    jsxAttributeCompletionStyle = 'braces',
                  },
                  updateImportsOnFileMove = 'always',
                },
                typescript = {
                  preferences = {
                    jsxAttributeCompletionStyle = 'braces',
                  },
                  updateImportsOnFileMove = 'always',
                },
                vtsls = {
                  autoUseWorkspaceTsdk = true,
                  enableMoveToFileCodeAction = true,
                  experimental = {
                    completion = {
                      enableServerSideFuzzyMatch = true,
                    },
                  },
                },
              },
            }
          end,
          yamlls = function()
            lspconfig.yamlls.setup {
              capabilities = capabilities,
              settings = {
                redhat = { telemetry = { enabled = false } },
                yaml = {
                  keyOrdering = false,
                  schemaStore = {
                    enable = false,
                    url = '',
                  },
                  schemas = require('schemastore').yaml.schemas(),
                },
              },
            }
          end,
        },
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    event = { 'BufReadPre', 'BufNew', 'BufNewFile' },
    cmd = { 'LspInfo', 'LspLog', 'LspRestart', 'LspStart', 'LspStop' },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lspconfig = require 'lspconfig'

      lspconfig.hls.setup { capabilities = capabilities }
      lspconfig.ocamllsp.setup { capabilities = capabilities }
      lspconfig.tilt_ls.setup { capabilities = capabilities }
      lspconfig.zls.setup { capabilities = capabilities }
    end,
  },
  {
    'yioneko/nvim-vtsls',
    ft = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    },
  },
}
