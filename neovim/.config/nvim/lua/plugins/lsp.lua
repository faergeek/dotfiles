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
  { 'folke/lazydev.nvim', ft = 'lua', opts = {} },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'folke/neoconf.nvim' },
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
          'clangd',
          'cssls',
          'cssmodules_ls',
          'dockerls',
          'eslint',
          'html',
          'hyprls',
          'jsonls',
          'lua_ls',
          'marksman',
          'rust_analyzer',
          'stylelint_lsp',
          'taplo',
          'ts_ls',
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
          ts_ls = function()
            lspconfig.ts_ls.setup {
              capabilities = capabilities,
              handlers = {
                ['_typescript.rename'] = function(_, result, ctx)
                  if not result then return {} end

                  local client = vim.lsp.get_client_by_id(ctx.client_id)

                  if client then
                    vim.lsp.util.jump_to_location({
                      uri = result.textDocument.uri,
                      range = {
                        start = result.position,
                        ['end'] = result.position,
                      },
                    }, client.offset_encoding)

                    vim.lsp.buf.rename(nil, {
                      filter = function(c) return c == client end,
                    })
                  end

                  return {}
                end,
              },
              init_options = {
                preferences = {
                  includeInlayParameterNameHints = 'all',
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
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
}
