return {
  {
    'folke/lazydev.nvim',
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
    config = function()
      if vim.fn.executable 'tilt' == 1 then vim.lsp.enable 'tilt_ls' end

      if vim.fn.executable 'ocamllsp' == 1 then vim.lsp.enable 'ocamllsp' end

      if vim.fn.executable 'haskell-language-server-wrapper' == 1 then
        vim.lsp.enable 'hls'
      end
    end,
  },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = { 'mason.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      ensure_installed = {
        'bashls',
        'cssls',
        'dockerls',
        'eslint',
        'html',
        'jsonls',
        'lua_ls',
        'markdown_oxide',
        'vtsls',
        'yamlls',
      },
    },
  },
  {
    'yioneko/nvim-vtsls',
    dependencies = { 'neovim/nvim-lspconfig' },
  },
}
