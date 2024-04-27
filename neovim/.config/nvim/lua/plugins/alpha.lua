return {
  {
    'goolord/alpha-nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      {
        'rubiin/fortune.nvim',
        opts = {
          {
            max_width = 70,
            display_format = 'mixed',
            content_type = 'mixed',
          },
        },
      },
    },
    opts = function()
      local autocmd = require('utils').autocmd

      local function button(sc, val, keybind)
        return {
          type = 'button',
          val = val,
          opts = {
            align_shortcut = 'right',
            hl_shortcut = {
              { 'AlphaButtons', 0, 1 },
              { 'AlphaShortcut', 1, #sc + 1 },
              { 'AlphaButtons', #sc + 1, #sc + 2 },
            },
            keymap = {
              'n',
              sc,
              keybind,
              { noremap = true, silent = true, nowait = true },
            },
            position = 'center',
            shortcut = '[' .. sc .. '] ',
            shrink_margin = false,
            width = 70,
          },
          on_press = function()
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes(
                keybind .. '<Ignore>',
                true,
                false,
                true
              ),
              't',
              false
            )
          end,
        }
      end

      local function get_extension(fn)
        local match = fn:match '^.+(%..+)$'
        local ext = ''
        if match ~= nil then ext = match:sub(2) end
        return ext
      end

      if vim.o.filetype == 'lazy' then
        vim.cmd.close()

        autocmd(
          'Show lazy once alpha is ready',
          'User',
          function() require('lazy').show() end,
          {
            once = true,
            pattern = 'AlphaReady',
          }
        )
      end

      return {
        opts = { margin = 1 },
        layout = {
          { type = 'padding', val = 1 },
          {
            type = 'text',
            val = {
              [[                                                                   ]],
              [[      ████ ██████           █████      ██                    ]],
              [[     ███████████             █████                            ]],
              [[     █████████ ███████████████████ ███   ███████████  ]],
              [[    █████████  ███    █████████████ █████ ██████████████  ]],
              [[   █████████ ██████████ █████████ █████ █████ ████ █████  ]],
              [[ ███████████ ███    ███ █████████ █████ █████ ████ █████ ]],
              [[██████  █████████████████████ ████ █████ █████ ████ ██████]],
            },
            opts = {
              hl = {
                { { 'AlphaShortcut', 0, -1 } },
                { { 'AlphaHeader', 0, 62 }, { 'AlphaShortcut', 62, -1 } },
                { { 'AlphaHeader', 0, 65 }, { 'AlphaShortcut', 65, -1 } },
                { { 'AlphaHeader', 0, 92 }, { 'AlphaShortcut', 92, -1 } },
                { { 'AlphaHeader', 0, 85 }, { 'AlphaShortcut', 85, -1 } },
                { { 'AlphaHeader', 0, 98 }, { 'AlphaShortcut', 98, -1 } },
                { { 'AlphaHeader', 0, 97 }, { 'AlphaShortcut', 97, -1 } },
                { { 'AlphaHeader', 0, 107 }, { 'AlphaShortcut', 107, -1 } },
              },
              position = 'center',
              shrink_margin = false,
            },
          },
          {
            type = 'group',
            val = {
              { type = 'padding', val = 1 },
              {
                type = 'group',
                opts = { shrink_margin = false },
                val = function()
                  local function mru()
                    local function ignore(path, ext)
                      return (string.find(path, 'COMMIT_EDITMSG'))
                        or (vim.tbl_contains({ 'gitcommit' }, ext))
                    end

                    local items_number = 10
                    local oldfiles = {}
                    for _, v in pairs(vim.v.oldfiles) do
                      if #oldfiles == items_number then break end

                      if
                        (vim.fn.filereadable(v) == 1)
                        and vim.startswith(v, vim.fn.getcwd() .. '/')
                        and not ignore(v, get_extension(v))
                      then
                        oldfiles[#oldfiles + 1] = v
                      end
                    end

                    local function file_button(fn, sc)
                      local short_fn = vim.fn.fnamemodify(
                        fn,
                        ':p:~:.:gs?\\([.]*[^/]\\)[^/]*/?\\1/?'
                      )
                      local fb_hl = {}
                      local ico, hl = require('nvim-web-devicons').get_icon(
                        fn,
                        get_extension(fn),
                        { default = true }
                      )

                      if hl then table.insert(fb_hl, { hl, 0, #ico }) end

                      local ico_txt = ico .. ' '

                      local file_button_el = button(
                        sc,
                        ico_txt .. short_fn,
                        '<Cmd>edit ' .. vim.fn.fnameescape(fn) .. '' .. '<CR>'
                      )

                      local fn_start = short_fn:match '.*[/\\]'

                      if fn_start ~= nil then
                        table.insert(
                          fb_hl,
                          { 'AlphaButtons', #ico_txt, #fn_start + #ico_txt }
                        )
                      end

                      file_button_el.opts.hl = fb_hl

                      return file_button_el
                    end

                    local tbl = {}
                    for i, fn in ipairs(oldfiles) do
                      local sc = tostring(i - 1)
                      local file_button_el = file_button(fn, sc)

                      tbl[i] = file_button_el
                    end

                    return { type = 'group', val = tbl, opts = {} }
                  end

                  return { mru() }
                end,
              },
            },
          },
          { type = 'padding', val = 1 },
          {
            type = 'text',
            val = require('fortune').get_fortune(),
            opts = {
              hl = 'AlphaFooter',
              position = 'center',
              shrink_margin = false,
            },
          },
        },
      }
    end,
  },
}
