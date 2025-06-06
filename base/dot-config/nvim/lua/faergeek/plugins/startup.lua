return {
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    keys = {
      {
        'q',
        '<Cmd>q<CR>',
        ft = 'startuptime',
      },
    },
  },
  {
    'goolord/alpha-nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      {
        'rubiin/fortune.nvim',
        opts = {
          max_width = 70,
          display_format = 'mixed',
          content_type = 'mixed',
        },
      },
    },
    opts = function()
      ---@param sc string
      ---@param val string
      ---@param keybind string
      ---@param ico string|nil
      ---@param ico_hl string|nil
      ---@return table
      local function button(sc, val, keybind, ico, ico_hl)
        local ico_txt = ico and ico .. ' '
        local sc_txt = '[' .. sc .. '] '

        return {
          type = 'button',
          val = ico_txt and ico_txt .. val or val,
          opts = {
            cursor = 1,
            hl = ico_txt
              and { { ico_hl or 'AlphaButtons', #sc_txt, #sc_txt + #ico_txt } },
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
            shortcut = sc_txt,
            shrink_margin = false,
          },
          on_press = function()
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes(keybind, true, false, true),
              't',
              false
            )
          end,
        }
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
            opts = { hl = 'AlphaHeader', shrink_margin = false },
          },
          {
            type = 'text',
            val = require('fortune').get_fortune(),
            opts = { hl = 'AlphaHeaderLabel', shrink_margin = false },
          },
          { type = 'padding', val = 1 },
          button('e', 'New file', '<Cmd>enew<CR>'),
          button('l', 'Lazy', '<Cmd>Lazy<CR>'),
          button('m', 'Mason', '<Cmd>Mason<CR>'),
          button('q', 'Quit', '<Cmd>q<CR>'),
          {
            type = 'group',
            opts = { shrink_margin = false },
            val = function()
              local max_items = 10
              local result = {}
              for _, path in ipairs(vim.v.oldfiles) do
                if #result == max_items then break end

                if
                  vim.uv.fs_stat(path)
                  and vim.startswith(path, vim.fn.getcwd())
                then
                  local val =
                    vim.fn.fnamemodify(path, ':.:gs?\\([.]*[^/]\\)[^/]*/?\\1/?')

                  local keybind = '<Cmd>edit '
                    .. vim.fn.fnameescape(vim.fn.fnamemodify(path, ':.'))
                    .. '<CR>'

                  local ico, ico_hl = require('nvim-web-devicons').get_icon(
                    vim.fn.fnamemodify(path, ':t'),
                    vim.fn.fnamemodify(path, ':e')
                  )

                  result[#result + 1] =
                    button(tostring(#result), val, keybind, ico, ico_hl)
                end
              end

              if #result ~= 0 then
                table.insert(result, 0, { type = 'padding', val = 1 })

                table.insert(result, 1, {
                  type = 'text',
                  val = 'Recent files:',
                  opts = { hl = 'SpecialComment' },
                })
              end

              return result
            end,
          },
        },
      }
    end,
    config = function(_, opts)
      require('alpha').setup(opts)

      if vim.o.filetype == 'lazy' then
        vim.cmd.close()

        vim.api.nvim_create_autocmd('User', {
          callback = function() require('lazy').show() end,
          once = true,
          pattern = 'AlphaReady',
        })
      end

      vim.api.nvim_create_autocmd('DirChanged', {
        command = 'AlphaRedraw | AlphaRemap',
      })
    end,
  },
  {
    'rmagatti/auto-session',
    lazy = false,
    keys = {
      {
        desc = 'Session: Save',
        '<leader>ss',
        '<Cmd>SessionSave<CR>',
      },
      {
        desc = 'Session: Delete',
        '<leader>sd',
        '<Cmd>SessionDelete<CR>',
      },
    },
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      args_allow_single_directory = false,
      auto_create = false,
      git_use_branch_name = true,
      session_lens = {
        load_on_setup = false,
      },
    },
  },
}
