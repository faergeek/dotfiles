local packer_path = (
  vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
)

local is_bootstrap = vim.fn.empty(vim.fn.glob(packer_path)) > 0

if is_bootstrap then
  vim.fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    packer_path,
  }

  vim.cmd.packadd 'packer.nvim'
end

require('packer').startup {
  function(use)
    use 'wbthomason/packer.nvim'

    -- after/plugin/ui.lua
    use {
      'nvim-tree/nvim-web-devicons',
      'folke/tokyonight.nvim',
      'stevearc/dressing.nvim',
      'goolord/alpha-nvim',
      'nvim-lualine/lualine.nvim',
      {
        'j-morano/buffer_manager.nvim',
        requires = 'nvim-lua/plenary.nvim',
      },
      'kdheepak/tabline.nvim',
      'j-hui/fidget.nvim',
      'folke/trouble.nvim',
      'stevearc/oil.nvim',
    }

    -- after/plugin/sessions.lua
    use {
      'ethanholz/nvim-lastplace',
      'rmagatti/auto-session',
      'rmagatti/session-lens',
    }

    -- after/plugin/editing.lua
    use {
      'nmac427/guess-indent.nvim',
      'lukas-reineke/indent-blankline.nvim',

      'nvim-treesitter/nvim-treesitter',
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-treesitter-context',

      'antonk52/vim-browserslist',

      {
        'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async',
      },

      'JoosepAlviste/nvim-ts-context-commentstring',
      'numToStr/Comment.nvim',

      'windwp/nvim-autopairs',
      'windwp/nvim-ts-autotag',
      'RRethy/nvim-treesitter-endwise',
      'echasnovski/mini.surround',

      'NvChad/nvim-colorizer.lua',

      run = function()
        pcall(require('nvim-treesitter.install').update {
          with_sync = true,
        })
      end,
    }

    -- after/plugin/mason.lua
    use {
      'williamboman/mason.nvim',

      'folke/neodev.nvim',
      'neovim/nvim-lspconfig',
      'williamboman/mason-lspconfig.nvim',

      'jose-elias-alvarez/null-ls.nvim',
      'jayp0521/mason-null-ls.nvim',

      requires = 'nvim-lua/plenary.nvim',
    }

    -- after/plugin/snippets.lua
    use 'L3MON4D3/LuaSnip'

    -- after/plugin/completion.lua
    use {
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'onsails/lspkind.nvim',
      'saadparwaiz1/cmp_luasnip',
    }

    -- after/plugin/git.lua
    use {
      'lewis6991/gitsigns.nvim',
    }

    -- after/plugin/telescope.lua
    use {
      {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = { 'nvim-lua/plenary.nvim' },
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        cond = vim.fn.executable 'make' == 1,
      },
    }

    if is_bootstrap then
      require('packer').sync()
    end
  end,

  config = {
    display = {
      prompt_border = 'single',
      open_fn = function()
        return require('packer.util').float { border = 'single' }
      end,
    },
  },
}

vim.opt.guicursor =
  'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait300-blinkon200-blinkoff150'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.list = true
vim.opt.listchars = 'tab:» ,extends:…,precedes:…,trail:·,nbsp:␣'
vim.opt.showmatch = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.breakindentopt = 'sbr'
vim.opt.textwidth = 80
vim.opt.linebreak = true
vim.opt.showbreak = '↳ '
vim.opt.cpoptions:append 'n'

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = '1'
vim.opt.fillchars = 'fold: ,foldopen:,foldsep: ,foldclose:'

vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.showmode = false
vim.opt.shortmess = 'aoOtTWcFS'
vim.opt.title = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 20
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.backupcopy = 'yes'
vim.opt.sessionoptions =
  'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local autocmd = require('faergeek.utils').autocmd
local keymap = require('faergeek.utils').keymap

keymap('Nop', { 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

keymap('Move cursor up', 'n', 'k', "v:count == 0 ? 'gk' : 'k'", {
  expr = true,
  silent = true,
})

keymap('Move cursor down', 'n', 'j', "v:count == 0 ? 'gj' : 'j'", {
  expr = true,
  silent = true,
})

keymap('Move selection up', 'v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
keymap('Move selection down', 'v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

keymap('Join next line, preserving cursor position', 'n', 'J', 'mzJ`z')

keymap('Quickfix: Next item', 'n', '<C-j>', ':cnext<CR>')
keymap('Quickfix: Previous item', 'n', '<C-k>', ':cprev<CR>')

autocmd('Briefly highlight yanked text', 'TextYankPost', function()
  vim.highlight.on_yank {}
end)

autocmd('Override options for terminal buffers', 'TermOpen', function()
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn = 'auto'
  vim.opt_local.foldcolumn = '0'
end)

autocmd('Close terminal if job exited without an error', 'TermClose', function()
  if vim.v.event.status == 0 then
    vim.api.nvim_buf_delete(0, {})
  end
end)

keymap('LSP: [R]ename [S]ymbol', 'n', '<leader>rs', vim.lsp.buf.rename)
keymap('LSP: Code [A]ction', { 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action)
keymap('LSP: [G]o to [R]eferences', 'n', 'gr', ':Trouble lsp_references<CR>')

local function lsp_handle_capability(bufnr, client, capability, callback)
  local handled_flag_key = 'faergeek_lsp_attach_handled_' .. capability

  if
    not vim.b[bufnr][handled_flag_key]
    and client.server_capabilities[capability]
  then
    vim.b[bufnr][handled_flag_key] = true
    callback()
  end
end

autocmd('Setup LSP', 'LspAttach', function(args)
  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  lsp_handle_capability(bufnr, client, 'hoverProvider', function()
    keymap('LSP: Hover Documentation', 'n', 'K', vim.lsp.buf.hover, {
      buffer = bufnr,
    })
  end)

  lsp_handle_capability(bufnr, client, 'documentSymbolProvider', function()
    keymap(
      'LSP: Document Symbols',
      'n',
      'gO',
      require('telescope.builtin').lsp_document_symbols,
      { buffer = bufnr }
    )
  end)

  lsp_handle_capability(bufnr, client, 'workspaceSymbolProvider', function()
    keymap(
      'LSP: Workspace Symbols',
      'n',
      '<C-t>',
      require('telescope.builtin').lsp_dynamic_workspace_symbols,
      { buffer = bufnr }
    )
  end)

  if client.name == 'eslint' then
    client.server_capabilities.documentFormattingProvider = true
  end

  if client.name == 'sumneko_lua' then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  if client.name == 'tsserver' then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  lsp_handle_capability(bufnr, client, 'documentFormattingProvider', function()
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
      vim.lsp.buf.format {
        bufnr = bufnr,
        filter = function(c)
          return c.supports_method 'textDocument/formatting'
        end,
      }
    end, { desc = 'Format current buffer using LSP' })

    autocmd(
      'Format file on save using LSP',
      'BufWritePre',
      'Format',
      { buffer = bufnr }
    )
  end)
end)
