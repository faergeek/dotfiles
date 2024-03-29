return {
  {
    'L3MON4D3/LuaSnip',
    version = '2.*',
    build = 'make install_jsregexp',
    keys = function()
      local ls = require 'luasnip'

      return {
        {
          desc = 'LuaSnip: Jump forward',
          mode = { 'i', 's' },
          '<C-f>',
          function()
            if ls.jumpable(1) then ls.jump(1) end
          end,
        },
        {
          desc = 'LuaSnip: Jump backward',
          mode = { 'i', 's' },
          '<C-b>',
          function()
            if ls.jumpable(-1) then ls.jump(-1) end
          end,
        },
      }
    end,
    opts = {
      update_events = { 'TextChanged', 'TextChangedI' },
    },
    config = function(_, opts)
      local ls = require 'luasnip'

      ls.setup(opts)

      ls.filetype_extend('javascriptreact', {
        'javascript',
      })

      ls.filetype_extend('typescript', {
        'javascript',
      })

      ls.filetype_extend('typescriptreact', {
        'javascript',
        'javascriptreact',
        'typescript',
      })

      require('luasnip.loaders.from_lua').lazy_load()
    end,
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

      {
        'rcarriga/cmp-dap',
        dependencies = { 'hrsh7th/nvim-cmp' },
        ft = { 'dap-repl', 'dapui_watches', 'dapui_hover' },
        config = function()
          require('cmp').setup.filetype(
            { 'dap-repl', 'dapui_watches', 'dapui_hover' },
            {
              sources = {
                { name = 'dap' },
              },
            }
          )
        end,
      },
    },
    opts = function()
      local cmp = require 'cmp'

      return {
        enabled = function()
          return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt'
            or require('cmp_dap').is_dap_buffer()
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
                local icon = require('nvim-web-devicons').get_icon(
                  entry:get_completion_item().label
                )

                if icon then vim_item.abbr = icon .. ' ' .. vim_item.abbr end
              end

              return vim_item
            end,
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
      }
    end,
  },
}
