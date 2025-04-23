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
    dependencies = { 'mason.nvim', 'b0o/schemastore.nvim' },
    event = 'FileType',
    cmd = { 'LspInstall', 'LspUninstall' },
    opts = function()
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
          function(server_name) vim.lsp.enable(server_name) end,
          eslint = function() lspconfig.eslint.setup {} end,
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
        },
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    event = 'FileType',
    cmd = { 'LspInfo', 'LspLog', 'LspRestart', 'LspStart', 'LspStop' },
    config = function() vim.lsp.enable { 'hls', 'ocamllsp', 'tilt_ls' } end,
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
