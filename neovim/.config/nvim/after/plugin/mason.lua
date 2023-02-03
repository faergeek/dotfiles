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
    'jsonls',
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
  ['jsonls'] = function()
    lspconfig.jsonls.setup {
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    }
  end,
  ['stylelint_lsp'] = function()
    lspconfig.stylelint_lsp.setup {
      capabilities = capabilities,
      filetypes = { 'css' },
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
  ensure_installed = {
    'prettier',
    'stylua',
  },
}

local null_ls = require 'null-ls'

require('mason-null-ls').setup_handlers {
  function(source_name, methods)
    require 'mason-null-ls.automatic_setup'(source_name, methods)
  end,
  prettier = function()
    null_ls.register(null_ls.builtins.formatting.prettier.with {
      only_local = 'node_modules/.bin',
    })
  end,
}

null_ls.setup()

require('mason-nvim-dap').setup {
  ensure_installed = {
    'firefox',
    'node2',
  },
}

local dap = require 'dap'

require('mason-nvim-dap').setup_handlers {
  firefox = function()
    dap.adapters.firefox = {
      command = 'firefox-debug-adapter',
      type = 'executable',
    }
  end,
  node2 = function()
    dap.adapters.node2 = {
      command = 'node-debug2-adapter',
      type = 'executable',
    }

    local config = {
      name = 'Node: Attach',
      type = 'node2',
      request = 'attach',
    }

    dap.configurations.javascript = { config }
    dap.configurations.javascriptreact = { config }
    dap.configurations.typescript = { config }
    dap.configurations.typescriptreact = { config }
  end,
}
