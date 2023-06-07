return {
  {
    'L3MON4D3/LuaSnip',
    keys = {
      {
        desc = 'LuaSnip: Choise forward',
        mode = 'i',
        '<C-n>',
        function()
          if require('luasnip').choice_active() then
            require('luasnip').change_choice(1)
          end
        end,
      },
      {
        desc = 'LuaSnip: Choise backward',
        mode = 'i',
        '<C-p>',
        function()
          if require('luasnip').choice_active() then
            require('luasnip').change_choice(-1)
          end
        end,
      },
      {
        desc = 'LuaSnip: Expand snippet',
        mode = { 'i', 's' },
        '<C-y>',
        function()
          if require('luasnip').expandable() then
            require('luasnip').expand {}
          end
        end,
      },
      {
        desc = 'LuaSnip: Jump forward',
        mode = { 'i', 's' },
        '<C-f>',
        function()
          if require('luasnip').jumpable(1) then require('luasnip').jump(1) end
        end,
      },
      {
        desc = 'LuaSnip: Jump backward',
        mode = { 'i', 's' },
        '<C-b>',
        function()
          if require('luasnip').jumpable(-1) then
            require('luasnip').jump(-1)
          end
        end,
      },
    },
    opts = { history = true },
    config = function(_, opts) require('luasnip').config.set_config(opts) end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',

      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'onsails/lspkind.nvim',
      'nvim-tree/nvim-web-devicons',

      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    opts = function()
      local cmp = require 'cmp'

      return {
        enabled = function()
          return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt'
            or (
              package.loaded['cmp_dap'] ~= nil
              and require('cmp_dap').is_dap_buffer()
            )
        end,
        experimental = {
          ghost_text = {
            hl_group = 'LspCodeLens',
          },
        },
        formatting = {
          format = require('lspkind').cmp_format {
            before = function(entry, vim_item)
              if vim.tbl_contains({ 'path' }, entry.source.name) then
                local icon, hl_group = require('nvim-web-devicons').get_icon(
                  entry:get_completion_item().label
                )

                if icon then
                  vim_item.kind = icon
                  vim_item.kind_hl_group = hl_group
                end
              end

              return vim_item
            end,
            menu = {
              buffer = '[buf]',
              nvim_lsp = '[lsp]',
              path = '[path]',
              luasnip = '[snip]',
            },
            mode = 'symbol',
          },
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
        },
        snippet = {
          expand = function(args) require('luasnip').lsp_expand(args.body) end,
        },
        sources = cmp.config.sources({
          {
            name = 'path',
            options = { label_trailing_slash = true, trailing_slash = true },
          },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      }
    end,
  },
}
