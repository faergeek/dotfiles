local function lsp_config_on_attach(_, bufnr)
  local builtin = require 'telescope.builtin'

  local keymap = require('faergeek.utils').keymap

  keymap(
    'LSP: [R]ename [S]ymbol',
    'n',
    '<leader>rs',
    vim.lsp.buf.rename,
    { buffer = bufnr }
  )

  keymap(
    'LSP: Code [A]ction',
    { 'n', 'v' },
    '<leader>a',
    vim.lsp.buf.code_action,
    { buffer = bufnr }
  )

  keymap(
    '[T]rouble: LSP [R]eferences',
    'n',
    'gr',
    ':Trouble lsp_references<CR>'
  )

  keymap(
    'LSP: Document Symbols',
    'n',
    'gO',
    builtin.lsp_document_symbols,
    { buffer = bufnr }
  )

  keymap(
    'LSP: Workspace Symbols',
    'n',
    '<C-t>',
    builtin.lsp_dynamic_workspace_symbols,
    { buffer = bufnr }
  )

  keymap(
    'LSP: Hover Documentation',
    'n',
    'K',
    vim.lsp.buf.hover,
    { buffer = bufnr }
  )

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
    vim.lsp.buf.format {
      bufnr = bufnr,
      filter = function(client)
        if client.name == 'tsserver' then
          return false
        end

        if client.name == 'eslint' then
          client.server_capabilities.documentFormattingProvider = true
        end

        return client.supports_method 'textDocument/formatting'
      end,
    }
  end, { desc = 'Format current buffer with LSP' })

  local autocmd = require('faergeek.utils').autocmd

  autocmd('Format file on save using LSP', 'BufWritePre', 'Format', {
    buffer = bufnr,
  })
end

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
      on_attach = lsp_config_on_attach,
    }
  end,
  ['eslint'] = function()
    lspconfig.eslint.setup {
      capabilities = capabilities,
      on_attach = lsp_config_on_attach,
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
      on_attach = lsp_config_on_attach,
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

require('mason-null-ls').setup {
  automatic_setup = true,
  ensure_installed = {
    'prettierd',
    'stylua',
  },
}

require('null-ls').setup()

require('mason-null-ls').setup_handlers {}
