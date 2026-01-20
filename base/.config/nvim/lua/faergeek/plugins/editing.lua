return {
  'browserslist/vim-browserslist',
  'ashishbinu/vim-dotenv',
  'gpanders/nvim-parinfer',
  'towolf/vim-helm',
  'fladson/vim-kitty',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {},
    config = function(_, opts)
      local nvim_treesitter = require 'nvim-treesitter'
      nvim_treesitter.setup(opts)

      nvim_treesitter.install { 'diff', 'jsdoc', 'luadoc', 'luap', 'regex' }

      local languages = {}
      vim.list_extend(languages, nvim_treesitter.get_available(1))
      vim.list_extend(languages, nvim_treesitter.get_available(2))
      vim.list.unique(languages)

      local filetypes = {}
      for _, language in ipairs(languages) do
        vim.list_extend(
          filetypes,
          vim.treesitter.language.get_filetypes(language)
        )
      end

      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function(event)
          local language = vim.treesitter.language.get_lang(event.match)

          if
            vim.tbl_contains(nvim_treesitter.get_installed 'parsers', language)
          then
            vim.treesitter.start(event.buf, language)
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          else
            nvim_treesitter
              .install(language)
              :await(function() vim.treesitter.start(event.buf, language) end)
          end
        end,
      })
    end,
  },
  'RRethy/nvim-treesitter-endwise',
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      max_lines = 8,
      min_window_height = 20,
      mode = 'topline',
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = { break_undo = false },
  },
  {
    'RRethy/vim-illuminate',
    lazy = false,
    keys = {
      {
        desc = 'Next Reference',
        ']r',
        function() require('illuminate').goto_next_reference() end,
      },
      {
        desc = 'Previous Reference',
        '[r',
        function() require('illuminate').goto_prev_reference() end,
      },
    },
  },
  {
    'Darazaki/indent-o-matic',
    event = 'BufReadPre',
    opts = {
      filetype_markdown = {
        standard_widths = { 2 },
      },
    },
  },
  { 'farmergreg/vim-lastplace', event = 'BufReadPre' },
  {
    'Wansmer/treesj',
    keys = {
      {
        desc = 'Split/Join',
        '<leader>j',
        '<Cmd>TSJToggle<CR>',
      },
    },
    opts = {
      max_join_length = 500,
      use_default_keymaps = false,
    },
  },
  {
    'kylechui/nvim-surround',
    keys = {
      {
        desc = 'Add a surrounding pair around the cursor (insert mode)',
        mode = 'i',
        '<C-g>s',
      },
      {
        desc = 'Add a surrounding pair around the cursor, on new lines (insert mode)',
        mode = 'i',
        '<C-g>S',
      },
      {
        desc = 'Add a surrounding pair around a motion (normal mode)',
        'ys',
      },
      {
        desc = 'Add a surrounding pair around the current line (normal mode)',
        'yss',
      },
      {
        desc = 'Add a surrounding pair around a motion, on new lines (normal mode)',
        'yS',
      },
      {
        desc = 'Add a surrounding pair around the current line, on new lines (normal mode)',
        'ySS',
      },
      {
        desc = 'Add a surrounding pair around a visual selection',
        mode = 'x',
        'S',
      },
      {
        desc = 'Add a surrounding pair around a visual selection, on new lines',
        mode = 'x',
        'gS',
      },
      {
        desc = 'Delete a surrounding pair',
        'ds',
      },
      {
        desc = 'Change a surrounding pair',
        'cs',
      },
      {
        desc = 'Change a surrounding pair, putting replacements on new lines',
        'cS',
      },
    },
    opts = {},
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    lazy = true,
    opts = {
      enable_autocmd = false,
      languages = {
        c = { __default = '// %s', __multiline = '/* %s */' },
      },
    },
  },
  {
    'numToStr/Comment.nvim',
    keys = {
      { desc = 'Comment toggle current line', 'gcc' },
      { desc = 'Comment toggle linewise (visual)', 'gc', mode = { 'x' } },
      { desc = 'Comment toggle current block', 'gbc' },
      { desc = 'Comment toggle blockwise (visual)', 'gb', mode = { 'x' } },
      { desc = 'Comment insert end of line', 'gcA' },
      { desc = 'Comment insert above', 'gcO' },
      { desc = 'Comment insert below', 'gco' },
    },
    opts = function()
      return {
        pre_hook = require(
          'ts_context_commentstring.integrations.comment_nvim'
        ).create_pre_hook(),
      }
    end,
  },
  {
    'rlane/pounce.nvim',
    keys = {
      {
        desc = 'Jump',
        mode = { 'n', 'x', 'o' },
        '<leader><leader>',
        '<Cmd>Pounce<CR>',
      },
      {
        desc = 'Repeat Jump',
        mode = { 'n', 'x', 'o' },
        '<leader><leader><leader>',
        '<Cmd>PounceRepeat<CR>',
      },
    },
  },
  { 'brenoprata10/nvim-highlight-colors', opts = {} },
}
