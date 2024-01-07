return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {},
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'folke/neodev.nvim', opts = {} },
      'mason.nvim',
      {
        'neovim/nvim-lspconfig',
        dependencies = {
          'folke/neoconf.nvim',
          { 'j-hui/fidget.nvim', opts = {} },
        },
        config = function()
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          local lspconfig = require 'lspconfig'

          lspconfig.ocamllsp.setup { capabilities = capabilities }
          lspconfig.zls.setup { capabilities = capabilities }
        end,
      },
      'hrsh7th/cmp-nvim-lsp',
      'b0o/schemastore.nvim',
    },
    opts = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require 'lspconfig'

      local ensure_installed = {
        'bashls',
        'cssls',
        'cssmodules_ls',
        'eslint',
        'html',
        'jsonls',
        'stylelint_lsp',
        'tsserver',
        'yamlls',
      }

      local uv = vim.uv or vim.loop

      if uv.os_uname().machine ~= 'armv7l' then
        vim.list_extend(ensure_installed, {
          'clangd',
          'lua_ls',
          'marksman',
          'rust_analyzer',
          'taplo',
          'typos_lsp',
        })
      end

      return {
        ensure_installed = ensure_installed,
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
              on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = true
              end,
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
                  completion = { callSnippet = 'Replace' },
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
          tsserver = function()
            lspconfig.tsserver.setup {
              capabilities = capabilities,
              init_options = {
                preferences = {
                  jsxAttributeCompletionStyle = 'braces',
                },
              },
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
                    }, client.offset_encoding, true)

                    vim.lsp.buf.rename(nil, {
                      filter = function(c) return c == client end,
                    })
                  end

                  return {}
                end,
              },
            }
          end,
          yamlls = function()
            lspconfig.yamlls.setup {
              capabilities = capabilities,
              settings = {
                redhat = { telemetry = { enabled = false } },
                yaml = { keyOrdering = false },
              },
            }
          end,
        },
      }
    end,
  },
}
