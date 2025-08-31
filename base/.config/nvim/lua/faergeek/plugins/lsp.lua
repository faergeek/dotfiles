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
        'markdown_oxide',
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
