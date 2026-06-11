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

vim.diagnostic.config {
  float = {
    scope = 'cursor',
    source = true,
  },
  severity_sort = true,
  signs = false,
}

vim.lsp.enable {
  'gdscript',
  'hls',
  'ocamllsp',
  'tilt_ls',
}

vim.filetype.add {
  extension = {
    mli = 'ocamlinterface',
    mll = 'ocamllex',
    mly = 'ocamllex',
  },
  filename = {
    ['.eslintignore'] = 'gitignore',
    ['.swcrc'] = 'jsonc',
    ['Tiltfile'] = 'tiltfile',
  },
  pattern = {
    ['.*/%.config/fish/themes/.*%.theme'] = 'fish',
    ['.*/%.config/git/config%.local%.example'] = 'gitconfig',
    ['.*/%.config/git/config%.local'] = 'gitconfig',
    ['.*/%.config/swappy/config'] = 'ini',
    ['.*/%.config/uwsm/env'] = 'sh',
    ['.*/%.vscode/.*%.json'] = 'jsonc',
  },
}

vim.treesitter.language.register('starlark', 'tiltfile')

vim.loader.enable()

function _G.tabline()
  ---@type string[]
  local parts = {}

  local tabnr = vim.fn.tabpagenr()
  for i = 1, vim.fn.tabpagenr '$' do
    table.insert(parts, '%' .. i .. 'T')
    table.insert(parts, i == tabnr and '%#TabLineSel#' or '%#TabLine#')
    table.insert(parts, ' 󰓩 ' .. i .. ' ')
  end

  table.insert(parts, '%#TabLineFill#')

  return table.concat(parts, '')
end

---@param bufnr integer
---@return string
function _G.oil_buf_name(bufnr)
  local dir = require('oil').get_current_dir(bufnr)

  return dir and vim.fn.fnamemodify(dir, ':p:~:.:h')
    or vim.api.nvim_buf_get_name(bufnr)
end

function _G.statusline()
  ---@type string[]
  local parts = {}

  table.insert(parts, ' 󰕰 %{winnr()} %<')
  table.insert(
    parts,
    table.concat {
      '%{',
      '% &filetype == "dbui"          ? "DBUI"',
      ': exists("b:db")               ? "%t"',
      ': &filetype == "fugitive"      ? "Git Status"',
      ': &filetype == "fugitiveblame" ? "Git Blame"',
      ': &filetype == "git"           ? "Git"',
      ': &filetype == "help"          ? "%f"',
      ': &filetype == "oil"           ? \'%{v:lua.oil_buf_name(0)}\'',
      ':                                \'%{expand("%:p:~:.") ?? "[No Name]"}\'',
      '%}',
    }
  )
  table.insert(parts, '%( %m%)')
  table.insert(parts, '%( %r%)')
  table.insert(parts, '%=')
  table.insert(
    parts,
    '%(%( %{% exists("b:db") ? "%{db_ui#statusline()}" : "" %}%)%( %q%)%( %h%)%( %w%) %) %l:%c  %P '
  )

  return table.concat(parts, '')
end

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

vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(event)
    if vim.bo.buftype == 'help' then
      vim.opt_local.signcolumn = 'auto'
      vim.keymap.set('n', 'q', '<Cmd>q<CR>', { buffer = event.buf })
    end
  end,
})

vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'termguicolors',
  callback = function()
    if vim.o.termguicolors then
      vim.cmd.colorscheme 'catppuccin-nvim'
    else
      vim.cmd.colorscheme 'default'
    end
  end,
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = {
    'caddbuffer',
    'caddexpr',
    'caddfile',
    'cbuffer',
    'cexpr',
    'cfile',
    'cgetbuffer',
    'cgetexpr',
    'cgetfile',
    'make',
  },
  callback = function(event)
    local ns = vim.api.nvim_create_namespace 'QuickFixCmdPost'
    vim.diagnostic.reset(ns)

    local qf = vim.fn.getqflist { id = 0, items = 0 }

    ---@type integer[]
    local bufnrs = {}
    for _, item in ipairs(vim.diagnostic.fromqflist(qf.items)) do
      if not vim.tbl_contains(bufnrs, item.bufnr) then
        bufnrs[#bufnrs + 1] = item.bufnr
      end
    end

    ---@param bufnr integer
    ---@param fn fun()
    local function once_loaded(bufnr, fn)
      if vim.api.nvim_buf_is_loaded(bufnr) then
        fn()
      else
        vim.api.nvim_create_autocmd('BufRead', {
          buffer = bufnr,
          callback = function() fn() end,
          once = true,
        })
      end
    end

    for _, bufnr in ipairs(bufnrs) do
      once_loaded(bufnr, function()
        qf = vim.fn.getqflist { id = qf.id, items = 0 }

        ---@type vim.Diagnostic[]
        local diagnostics = {}
        for _, item in ipairs(vim.diagnostic.fromqflist(qf.items)) do
          if item.bufnr == bufnr then
            item.source = event.match
            diagnostics[#diagnostics + 1] = item
          end
        end

        vim.diagnostic.set(ns, bufnr, diagnostics)
      end)
    end
  end,
})

vim.api.nvim_create_autocmd(
  'TextYankPost',
  { callback = function() vim.hl.on_yank {} end }
)
