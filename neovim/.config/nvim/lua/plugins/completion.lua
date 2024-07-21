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
          local cmp = require 'cmp'

          cmp.setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
            sources = cmp.config.sources({
              { name = 'dap' },
            }, {
              { name = 'buffer' },
            }),
          })
        end,
      },

      {
        'mtoohey31/cmp-fish',
        ft = 'fish',
        config = function()
          local cmp = require 'cmp'

          cmp.setup.filetype({ 'fish' }, {
            sources = cmp.config.sources({
              {
                name = 'path',
                option = {
                  get_cwd = function() return vim.fn.getcwd() end,
                  trailing_slash = true,
                },
              },
              { name = 'fish' },
            }, {
              { name = 'buffer' },
            }),
          })
        end,
      },
    },
    opts = function()
      local cmp = require 'cmp'

      return {
        enabled = function()
          local default = require 'cmp.config.default'()

          return default.enabled() or require('cmp_dap').is_dap_buffer()
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
        mapping = {
          ['<C-/>'] = {
            i = function()
              if cmp.visible_docs() then
                cmp.close_docs()
              else
                cmp.open_docs()
              end
            end,
          },
          ['<C-u>'] = { i = cmp.mapping.scroll_docs(-4) },
          ['<C-d>'] = { i = cmp.mapping.scroll_docs(4) },
          ['<C-Space>'] = { i = cmp.mapping.complete {} },
          ['<C-e>'] = { i = cmp.mapping.abort() },
          ['<C-y>'] = { i = cmp.mapping.confirm { select = false } },
          ['<C-n>'] = { i = cmp.mapping.select_next_item() },
          ['<C-p>'] = { i = cmp.mapping.select_prev_item() },
        },
        snippet = {
          expand = function(args) require('luasnip').lsp_expand(args.body) end,
        },
        sources = cmp.config.sources({
          {
            name = 'path',
            option = { trailing_slash = true },
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
