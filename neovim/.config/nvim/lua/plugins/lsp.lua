return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {
      ui = {
        border = 'single',
      },
    },
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
          {
            'j-hui/fidget.nvim',
            tag = 'legacy',
            opts = {
              text = {
                spinner = 'dots',
              },
              window = {
                blend = 0,
                relative = 'editor',
              },
            },
          },
        },
        config = function()
          local capabilities = require('cmp_nvim_lsp').default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
          )

          require('lspconfig').zls.setup { capabilities = capabilities }

          require('lspconfig').ocamllsp.setup {
            capabilities = capabilities,
          }
        end,
      },
      'hrsh7th/cmp-nvim-lsp',
      'b0o/schemastore.nvim',
      {
        'whynothugo/lsp_lines.nvim',
        url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        opts = {
          exclude_fts = { 'lazy' },
        },
        config = function(_, opts)
          require('lsp_lines').setup()

          local function is_excluded(bufnr)
            return vim.tbl_contains(
              opts.exclude_fts,
              vim.api.nvim_buf_get_option(bufnr, 'filetype')
            )
          end

          vim.diagnostic.config {
            virtual_lines = function(_, bufnr) return not is_excluded(bufnr) end,
            virtual_text = function(_, bufnr) return is_excluded(bufnr) end,
          }
        end,
      },
    },
    opts = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      )

      return {
        ensure_installed = {
          'bashls',
          'clangd',
          'cssls',
          'cssmodules_ls',
          'eslint',
          'html',
          'jsonls',
          'lua_ls',
          'rescriptls',
          'rust_analyzer',
          'stylelint_lsp',
          'taplo',
          'tsserver',
          'yamlls',
        },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup {
              capabilities = capabilities,
            }
          end,
          cssmodules_ls = function()
            require('lspconfig').cssmodules_ls.setup {
              capabilities = capabilities,
              init_options = {
                camelCase = false,
              },
            }
          end,
          eslint = function()
            require('lspconfig').eslint.setup {
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
            require('lspconfig').jsonls.setup {
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
            require('lspconfig').lua_ls.setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  completion = { callSnippet = 'Replace' },
                  format = { enable = false },
                  runtime = { version = 'LuaJIT' },
                  telemetry = { enable = false },
                  workspace = { checkThirdParty = false },
                },
              },
            }
          end,
          stylelint_lsp = function()
            require('lspconfig').stylelint_lsp.setup {
              capabilities = capabilities,
              filetypes = { 'css' },
              settings = {
                stylelintplus = { autoFixOnFormat = true },
              },
            }
          end,
          tsserver = function()
            require('lspconfig').tsserver.setup {
              capabilities = capabilities,
              init_options = {
                preferences = {
                  jsxAttributeCompletionStyle = 'braces',
                },
              },
            }
          end,
          yamlls = function()
            require('lspconfig').yamlls.setup {
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
