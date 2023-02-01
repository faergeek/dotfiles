local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

require('neodev').setup()

require('mason').setup {
  ui = {
    border = 'single',
  },
}

require('mason-lspconfig').setup {
  ensure_installed = {
    'cssls',
    'cssmodules_ls',
    'eslint',
    'html',
    'rust_analyzer',
    'stylelint_lsp',
    'sumneko_lua',
    'tsserver',
  },
}

require('lspconfig.ui.windows').default_options = {
  border = 'single',
}

local lspconfig = require 'lspconfig'

require('mason-lspconfig').setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
    }
  end,
  ['eslint'] = function()
    lspconfig.eslint.setup {
      capabilities = capabilities,
      settings = {
        codeActionOnSave = {
          enable = true,
          mode = 'all',
        },
      },
    }
  end,
  ['stylelint_lsp'] = function()
    lspconfig.stylelint_lsp.setup {
      capabilities = capabilities,
      settings = {
        stylelintplus = {
          autoFixOnFormat = true,
        },
      },
    }
  end,
  ['sumneko_lua'] = function()
    lspconfig.sumneko_lua.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          completion = { callSnippet = 'Replace' },
          runtime = { version = 'LuaJIT' },
          telemetry = { enable = false },
          workspace = { checkThirdParty = false },
        },
      },
    }
  end,
  ['tsserver'] = function()
    lspconfig.tsserver.setup {
      capabilities = capabilities,
      settings = {
        completions = {
          completeFunctionCalls = true,
        },
      },
    }
  end,
}

require('mason-null-ls').setup {
  automatic_setup = true,
  ensure_installed = {
    'prettierd',
    'stylua',
  },
}

require('null-ls').setup()

require('mason-null-ls').setup_handlers {}
