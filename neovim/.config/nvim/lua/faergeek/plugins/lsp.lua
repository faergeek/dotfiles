return {
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
    'neovim/nvim-lspconfig',
    dependencies = {
      'folke/neoconf.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    event = { 'BufReadPre', 'BufNew', 'BufNewFile' },
    cmd = { 'LspInfo', 'LspLog', 'LspRestart', 'LspStart', 'LspStop' },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require 'lspconfig'

      lspconfig.hls.setup {}

      lspconfig.ocamllsp.setup {
        capabilities = capabilities,
        settings = {
          extendedHover = { enable = true },
          inlayHints = { enable = true },
          syntaxDocumentation = { enable = true },
        },
      }
      lspconfig.tilt_ls.setup { capabilities = capabilities }
      lspconfig.zls.setup { capabilities = capabilities }
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'mason.nvim',
      'b0o/schemastore.nvim',
      'neovim/nvim-lspconfig',
    },
    event = { 'BufReadPre', 'BufNew', 'BufNewFile' },
    cmd = { 'LspInstall', 'LspUninstall' },
    opts = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require 'lspconfig'

      return {
        ensure_installed = {
          'bashls',
          'cssls',
          'eslint',
          'html',
          'jsonls',
          'lua_ls',
          'marksman',
          'tailwindcss',
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
              on_attach = function(client)
                client.server_capabilities.semanticTokensProvider = nil
              end,
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
                  hint = { enable = true, setType = true },
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
            lspconfig.tailwindcss.setup {
              settings = {
                tailwindCSS = {
                  experimental = {
                    classRegex = {
                      {
                        '(?:clsx|cn|cva|cx)\\(([^()]*(?:\\([^)]*\\)[^()]*)*)\\)',
                        '["\'`]([^"\'`]*)["\'`]',
                      },
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
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    ft = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    },
    opts = {},
  },
}
