local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt

return {
  ls.s(
    'fc',
    fmt(
      [[
      function {}({{{}}}) {{{}
        return {}
      }}
      ]],
      {
        ls.i(1, 'Component'),
        ls.i(2),
        ls.i(0),
        ls.d(
          3,
          function(args)
            return ls.sn(nil, {
              ls.i(1, '<h1>' .. args[1][1] .. '</h1>'),
            })
          end,
          1
        ),
      }
    )
  ),
}
