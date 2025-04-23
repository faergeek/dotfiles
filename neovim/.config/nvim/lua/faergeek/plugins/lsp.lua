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
    opts = {
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
        vim.lsp.enable,
        tailwindcss = function()
          vim.lsp.config('tailwindcss', {
            filetypes = vim.list_extend(
              vim.lsp.config.tailwindcss.filetypes,
              { 'ocaml' }
            ),
          })

          vim.lsp.enable 'tailwindcss'
        end,
      },
    },
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
