return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      integrations = {
        blink_cmp = true,
        fidget = true,
        mason = true,
        native_lsp = {
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        nvim_surround = true,
        pounce = true,
      },
      float = {
        solid = true,
        transparent = true,
      },
      transparent_background = true,
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('OptionSet', {
        callback = function()
          if vim.o.termguicolors then
            require('catppuccin').setup(opts)
            vim.cmd.colorscheme 'catppuccin'
          else
            vim.cmd.colorscheme 'default'
          end
        end,
        pattern = 'termguicolors',
      })
    end,
  },
  {
    'stevearc/oil.nvim',
    dependencies = 'nvim-mini/mini.icons',
    lazy = false,
    keys = {
      { desc = 'Oil', '-', '<Cmd>Oil<CR>' },
    },
    opts = {
      keymaps = {
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['q'] = 'actions.close',
        ['-'] = 'actions.parent',
        ['gx'] = 'actions.open_external',
      },
      lsp_file_methods = {
        autosave_changes = true,
        timeout_ms = 10000,
      },
      skip_confirm_for_simple_edits = true,
      use_default_keymaps = false,
      view_options = {
        show_hidden = true,
      },
    },
  },
  {
    'j-morano/buffer_manager.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {
        desc = 'Buffer Manager',
        '<leader>o',
        function() require('buffer_manager.ui').toggle_quick_menu() end,
      },
    },
    opts = {
      line_keys = '',
      show_indicators = 'after',
      width = 0.9,
    },
  },
}
