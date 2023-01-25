local cmp = require 'cmp'
local ls = require 'luasnip'
local icons = require 'nvim-web-devicons'
local lspkind = require 'lspkind'

cmp.setup {
  experimental = {
    ghost_text = true,
  },
  formatting = {
    format = lspkind.cmp_format {
      before = function(entry, vim_item)
        if vim.tbl_contains({ 'path' }, entry.source.name) then
          local icon, hl_group =
            icons.get_icon(entry:get_completion_item().label)

          if icon then
            vim_item.kind = icon
            vim_item.kind_hl_group = hl_group
          end
        end

        return vim_item
      end,
      menu = {
        buffer = '[buf]',
        calc = '[calc]',
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
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'calc' },
    {
      name = 'path',
      options = {
        label_trailing_slash = true,
        trailing_slash = true,
      },
    },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
}
