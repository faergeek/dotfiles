local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

return {
  ls.s(
    'fori',
    fmt(
      [[
      for (let {} = 0; {} < {}; {}++) {}
      ]],
      {
        ls.i(1, 'i'),
        rep(1),
        ls.i(2, '10'),
        rep(1),
        ls.i(0),
      }
    )
  ),
  ls.s(
    'forof',
    fmt(
      [[
      for (const {} of {}) {}
      ]],
      {
        ls.i(1, 'item'),
        ls.i(2, 'items'),
        ls.i(0),
      }
    )
  ),
  ls.s(
    'fn',
    fmt(
      [[
      function{}({}) {{
        {}
      }}
      ]],
      { ls.i(1), ls.i(2), ls.i(0) }
    )
  ),
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
  ls.s(
    'ust',
    fmt(
      [[
      const [{}, {}] = useState({})
      ]],
      {
        ls.i(1, 'state'),
        ls.f(function(args)
          local state_name = args[1][1] --[[@as string]]

          return 'set' .. state_name:sub(1, 1):upper() .. state_name:sub(2)
        end, 1),
        ls.i(2, "''"),
      }
    )
  ),
  ls.s(
    'ueff',
    fmt(
      [[
      useEffect(() => {{
        {}
      }}, [])
      ]],
      { ls.i(1) }
    )
  ),
  ls.s(
    'ulef',
    fmt(
      [[
      useLayoutEffect(() => {{
        {}
      }}, [])
      ]],
      { ls.i(1) }
    )
  ),
  ls.s(
    'umem',
    fmt(
      [[
      useMemo(() => {}, [])
      ]],
      { ls.i(1) }
    )
  ),
  ls.s(
    'ucb',
    fmt(
      [[
      useCallback(() => {}, [])
      ]],
      { ls.i(1) }
    )
  ),
}
