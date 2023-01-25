local function lsp_config_on_attach(_, bufnr)
  local builtin = require 'telescope.builtin'

  local keymap = require('faergeek.utils').keymap

  keymap(
    '[R]ename [S]ymbol',
    'n',
    '<leader>rs',
    vim.lsp.buf.rename,
    { buffer = bufnr }
  )

  keymap(
    '[C]ode [A]ction',
    { 'n', 'v' },
    '<leader>ca',
    vim.lsp.buf.code_action,
    { buffer = bufnr }
  )

  keymap('[G]oto [R]eferences', 'n', 'gr', function()
    builtin.lsp_references {
      include_declaration = false,
      show_line = false,
    }
  end, { buffer = bufnr })

  keymap(
    '[D]ocument [S]ymbols',
    'n',
    '<leader>ds',
    builtin.lsp_document_symbols,
    { buffer = bufnr }
  )

  keymap(
    'Workspace Symbols',
    'n',
    '<C-t>',
    builtin.lsp_dynamic_workspace_symbols,
    { buffer = bufnr }
  )

  keymap('Hover Documentation', 'n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

require('neodev').setup()
require('mason').setup()

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = {
    'cssls',
    'cssmodules_ls',
    'eslint',
    'rust_analyzer',
    'tsserver',
    'sumneko_lua',
  },
}

local lspconfig = require 'lspconfig'

mason_lspconfig.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
      on_attach = lsp_config_on_attach,
    }
  end,
  ['sumneko_lua'] = function()
    lspconfig.sumneko_lua.setup {
      capabilities = capabilities,
      on_attach = lsp_config_on_attach,
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
      on_attach = lsp_config_on_attach,
      settings = {
        completions = {
          completeFunctionCalls = true,
        },
      },
    }
  end,
}

local mason_null_ls = require 'mason-null-ls'

mason_null_ls.setup {
  automatic_setup = true,
  ensure_installed = {
    'prettierd',
    'stylua',
  },
}

require('null-ls').setup {
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
      vim.lsp.buf.format {
        bufnr = bufnr,
        filter = function(client)
          return (client.name == 'null-ls')
            and (client.supports_method 'textDocument/formatting')
        end,
      }
    end, { desc = 'Format current buffer with LSP' })

    local autocmd = require('faergeek.utils').autocmd

    autocmd('Format file on save using LSP', 'BufWritePre', 'Format', {
      buffer = bufnr,
    })
  end,
}

mason_null_ls.setup_handlers {}
