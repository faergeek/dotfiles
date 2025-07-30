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
  { 'j-hui/fidget.nvim', event = 'LspAttach', opts = {} },
  {
    'mason-org/mason.nvim',
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
  { 'b0o/schemastore.nvim', lazy = true },
  {
    'neovim/nvim-lspconfig',
    event = 'FileType',
    cmd = { 'LspInfo', 'LspLog', 'LspRestart', 'LspStart', 'LspStop' },
    config = function()
      vim.lsp.config('tailwindcss', {
        filetypes = vim.list_extend(
          vim.lsp.config.tailwindcss.filetypes,
          { 'ocaml' }
        ),
      })

      vim.lsp.enable { 'hls', 'ocamllsp', 'tilt_ls' }
    end,
  },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = { 'mason.nvim', 'neovim/nvim-lspconfig' },
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
    },
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
