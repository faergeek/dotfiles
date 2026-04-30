vim.opt.backupcopy = 'yes'
vim.opt.breakindent = true
if not vim.env.SSH_TTY then vim.opt.clipboard = 'unnamedplus' end
vim.opt.diffopt:append { 'algorithm:patience' }
vim.opt.diffopt:remove { 'linematch:40' }
vim.opt.expandtab = true
vim.opt.exrc = true
vim.opt.fillchars = {
  diff = ' ',
  fold = ' ',
  foldclose = '',
  foldopen = '',
}
vim.opt.fixeol = false
vim.opt.foldcolumn = 'auto:9'
vim.opt.foldlevelstart = 99
vim.opt.foldtext = ''
vim.opt.guicursor =
  'n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20,a:blinkwait300-blinkon200-blinkoff150'
vim.opt.guifont = 'FantasqueSansM Nerd Font'
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.jumpoptions:append 'view'
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = {
  extends = '…',
  leadmultispace = ' ',
  multispace = '·',
  nbsp = '␣',
  precedes = '…',
  tab = '» ',
  trail = '·',
}
vim.opt.modeline = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = false
vim.opt.scrolloff = 8
vim.opt.sessionoptions:remove {
  'blank',
  'curdir',
  'terminal',
}
vim.opt.shiftround = true
vim.opt.shiftwidth = 0
vim.opt.shortmess:append {
  W = true,
  c = true,
}
vim.opt.showbreak = '↳ '
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.statusline = '%!v:lua.statusline()'
vim.opt.tabline = '%!v:lua.tabline()'
vim.opt.tabstop = 2
vim.opt.undofile = true
vim.opt.wildignorecase = true

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.g.markdown_recommended_style = 0

vim.g.db_ui_show_database_icon = 1
vim.g.db_ui_force_echo_notifications = 1
vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_win_position = 'right'

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(event)
    if
      event.data.spec.name == 'nvim-treesitter'
      and event.data.kind == 'update'
    then
      if not event.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd.TSUpdate()
    end
  end,
})

vim.loader.enable()

---@param repo string
local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  { src = gh 'catppuccin/nvim', name = 'catppuccin' },
  gh 'nvim-mini/mini.icons',
  gh 'folke/snacks.nvim',
  gh 'farmergreg/vim-lastplace',
  gh 'folke/persistence.nvim',
  gh 'Darazaki/indent-o-matic',

  gh 'nvim-treesitter/nvim-treesitter',
  gh 'nvim-treesitter/nvim-treesitter-context',

  gh 'lewis6991/gitsigns.nvim',

  gh 'j-hui/fidget.nvim',
  gh 'mason-org/mason.nvim',
  gh 'b0o/schemastore.nvim',
  gh 'folke/lazydev.nvim',
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'yioneko/nvim-vtsls',
  { src = gh 'saghen/blink.cmp', version = vim.version.range '*' },
  gh 'mayromr/blink-cmp-dap',

  gh 'browserslist/vim-browserslist',
  gh 'RRethy/vim-illuminate',
  gh 'stevearc/oil.nvim',

  gh 'nvim-lua/plenary.nvim',
  gh 'j-morano/buffer_manager.nvim',

  gh 'RRethy/nvim-treesitter-endwise',
  gh 'nvim-mini/mini.pairs',
  gh 'gpanders/nvim-parinfer',
  gh 'stevearc/conform.nvim',
  gh 'Wansmer/treesj',
  gh 'kylechui/nvim-surround',
  gh 'JoosepAlviste/nvim-ts-context-commentstring',
  gh 'tpope/vim-commentary',
  gh 'brenoprata10/nvim-highlight-colors',

  gh 'tpope/vim-rhubarb',
  gh 'tpope/vim-fugitive',

  gh 'tpope/vim-dispatch',

  gh 'igorlfs/nvim-dap-view',
  gh 'mfussenegger/nvim-dap',

  gh 'tpope/vim-dadbod',
  gh 'kristijanhusak/vim-dadbod-ui',
  gh 'kristijanhusak/vim-dadbod-completion',
}

require('catppuccin').setup {
  auto_integrations = true,
  lsp_styles = {
    underlines = {
      errors = { 'undercurl' },
      hints = { 'undercurl' },
      warnings = { 'undercurl' },
      information = { 'undercurl' },
    },
  },
}

require('mini.icons').setup {}

require('snacks').setup {
  bigfile = { notify = false },
  image = {
    convert = { notify = false },
    doc = { enabled = false },
  },
  picker = {
    formatters = {
      file = { filename_first = true, truncate = 200 },
    },
  },
  quickfile = {},
}

require('persistence').setup {}

require('gitsigns').setup {
  attach_to_untracked = true,
  current_line_blame = true,
  current_line_blame_opts = {
    ignore_whitespace = true,
  },
  numhl = true,
}
