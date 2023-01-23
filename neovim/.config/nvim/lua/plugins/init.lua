local packer_path = (
  vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
)

local is_bootstrap = vim.fn.empty(vim.fn.glob(packer_path)) > 0

if is_bootstrap then
  vim.fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    packer_path,
  }

  vim.cmd.packadd 'packer.nvim'
end

local plugins = vim.api.nvim_create_augroup('plugins', {
  clear = true,
})

require('packer').startup {
  function(use)
    use 'wbthomason/packer.nvim'

    use {
      'folke/neodev.nvim',
      config = function()
        require('neodev').setup()
      end,
    }

    use {
      'williamboman/mason.nvim',
      config = function()
        require('mason').setup()
      end,
    }

    use {
      'williamboman/mason-lspconfig.nvim',
      after = {
        'mason.nvim',
        'neodev.nvim',
      },
      requires = {
        'neovim/nvim-lspconfig',
      },
      config = function()
        require('mason-lspconfig').setup {
          ensure_installed = {
            'cssls',
            'cssmodules_ls',
            'eslint',
            'rust_analyzer',
            'tsserver',
            'sumneko_lua',
          },
        }

        local function mason_lspconfig_on_attach(_, bufnr)
          local function map(modes, keys, func, desc)
            if desc then
              desc = 'LSP: ' .. desc
            end

            vim.keymap.set(modes, keys, func, { buffer = bufnr, desc = desc })
          end

          map('n', '<leader>rs', vim.lsp.buf.rename, '[R]ename [S]ymbol')

          map(
            { 'n', 'v' },
            '<leader>ca',
            vim.lsp.buf.code_action,
            '[C]ode [A]ction'
          )

          map('n', 'gr', function()
            require('telescope.builtin').lsp_references(
              require('telescope.themes').get_cursor()
            )
          end, '[G]oto [R]eferences')

          map(
            'n',
            '<leader>td',
            vim.lsp.buf.type_definition,
            '[T]ype [D]efinition'
          )

          map(
            'n',
            '<leader>ds',
            require('telescope.builtin').lsp_document_symbols,
            '[D]ocument [S]ymbols'
          )

          map(
            'n',
            '<leader>ws',
            require('telescope.builtin').lsp_dynamic_workspace_symbols,
            '[W]orkspace [S]ymbols'
          )

          map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')

          map(
            'n',
            '<C-k>',
            vim.lsp.buf.signature_help,
            'Signature Documentation'
          )
        end

        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities(
          vim.lsp.protocol.make_client_capabilities()
        )

        require('mason-lspconfig').setup_handlers {
          function(server_name)
            require('lspconfig')[server_name].setup {
              capabilities = lsp_capabilities,
              on_attach = mason_lspconfig_on_attach,
            }
          end,
          ['sumneko_lua'] = function()
            require('lspconfig').sumneko_lua.setup {
              capabilities = lsp_capabilities,
              on_attach = mason_lspconfig_on_attach,
              settings = {
                Lua = {
                  completion = { callSnippet = 'Replace' },
                  runtime = { version = 'LuaJIT' },
                  telemetry = { enable = false },
                  workspace = { checkThirdParty = false },
                },
              },
            }
          end,
          ['tsserver'] = function()
            require('lspconfig').tsserver.setup {
              capabilities = lsp_capabilities,
              on_attach = mason_lspconfig_on_attach,
              settings = {
                completions = {
                  completeFunctionCalls = true,
                },
              },
            }
          end,
        }
      end,
    }

    use {
      'jayp0521/mason-null-ls.nvim',
      after = {
        'mason.nvim',
      },
      requires = {
        'nvim-lua/plenary.nvim',
        'jose-elias-alvarez/null-ls.nvim',
      },
      config = function()
        require('mason-null-ls').setup {
          automatic_setup = true,
          ensure_installed = {
            'prettierd',
            'stylua',
          },
        }

        require('null-ls').setup {
          on_attach = function(_, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
              vim.lsp.buf.format {
                bufnr = bufnr,
                filter = function(client)
                  return (client.name == 'null-ls')
                    and (client.supports_method 'textDocument/formatting')
                end,
              }
            end, { desc = 'Format current buffer with LSP' })

            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              group = plugins,
              desc = 'Format file on save using LSP',
              command = 'Format',
            })
          end,
        }

        require('mason-null-ls').setup_handlers {}
      end,
    }

    use {
      'L3MON4D3/LuaSnip',
      config = function()
        local ls = require 'luasnip'

        ls.config.set_config {
          history = true,
        }

        vim.keymap.set({ 'i', 's' }, '<C-x>', function()
          if ls.expandable() then
            ls.expand {}
          end
        end)

        vim.keymap.set({ 'i', 's' }, '<C-f>', function()
          if ls.jumpable(1) then
            ls.jump(1)
          end
        end)

        vim.keymap.set({ 'i', 's' }, '<C-b>', function()
          if ls.jumpable(-1) then
            ls.jump(-1)
          end
        end)

        vim.keymap.set('i', '<C-j>', function()
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end)

        vim.keymap.set('i', '<C-k>', function()
          if ls.choice_active() then
            ls.change_choice(-1)
          end
        end)
      end,
    }

    use {
      'hrsh7th/nvim-cmp',
      after = 'LuaSnip',
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-calc',
        'onsails/lspkind.nvim',
      },
      config = function()
        local cmp = require 'cmp'

        cmp.setup {
          formatting = {
            format = require('lspkind').cmp_format {
              mode = 'symbol',
              menu = {
                buffer = '[buf]',
                calc = '[calc]',
                nvim_lsp = '[lsp]',
                path = '[path]',
                luasnip = '[snip]',
              },
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
            },
          },
          mapping = cmp.mapping.preset.insert {
            ['<C-b>'] = cmp.mapping.scroll_docs(-1),
            ['<C-f>'] = cmp.mapping.scroll_docs(1),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete {},
            ['<C-c>'] = cmp.mapping.abort(),
            ['<C-x>'] = cmp.mapping.confirm { select = true },
          },
          snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body)
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
        }
      end,
    }

    use {
      'rose-pine/neovim',
      as = 'rose-pine',
      config = function()
        require('rose-pine').setup {
          disable_background = true,
          disable_float_background = true,
        }

        vim.cmd.colorscheme 'rose-pine'
      end,
    }

    use {
      'stevearc/dressing.nvim',
      config = function()
        require('dressing').setup {
          input = {
            insert_only = false,
            start_in_insert = false,
          },
        }
      end,
    }

    use {
      'rmagatti/auto-session',
      config = function()
        require('auto-session').setup {
          auto_session_create_enabled = false,
          auto_session_use_git_branch = true,
        }
      end,
    }

    use {
      'rmagatti/session-lens',
      requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
      config = function()
        require('session-lens').setup {}
        require('telescope').load_extension 'session-lens'
      end,
    }

    use {
      'goolord/alpha-nvim',
      requires = 'nvim-tree/nvim-web-devicons',
      config = function()
        local alpha = require 'alpha'
        local fortune = require 'alpha.fortune'
        local theme = require 'alpha.themes.theta'

        theme.header.val = {
          '                                                     ',
          '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
          '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
          '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
          '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
          '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
          '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
          '                                                     ',
          unpack(fortune()),
        }

        alpha.setup(theme.config)
      end,
    }

    use {
      'nvim-lualine/lualine.nvim',
      event = 'ColorScheme',
      requires = 'nvim-tree/nvim-web-devicons',
      config = function()
        require('lualine').setup {
          options = {
            globalstatus = true,
            theme = 'rose-pine',
          },
          sections = {
            lualine_a = {
              require('auto-session-library').current_session_name,
              { 'mode' },
            },
          },
        }
      end,
    }

    use {
      'kdheepak/tabline.nvim',
      requires = 'nvim-tree/nvim-web-devicons',
      config = function()
        require('tabline').setup {
          options = {
            show_filename_only = true,
          },
        }

        vim.keymap.set('n', '<leader>sb', vim.cmd.TablineToggleShowAllBuffers, {
          desc = '[S]how [B]uffers',
        })

        vim.keymap.set('n', '<leader>tr', function()
          vim.ui.input({ prompt = 'Enter new tab name: ' }, function(new_name)
            if not new_name then
              return
            end

            if new_name == '' then
              vim.cmd.TablineTabRename(
                tostring(vim.api.nvim_get_current_tabpage())
              )
            else
              vim.cmd.TablineTabRename(new_name)
            end
          end)
        end, {
          desc = '[T]ab [R]ename',
        })
      end,
    }

    use {
      'kevinhwang91/nvim-hlslens',
      config = function()
        require('hlslens').setup {
          calm_down = true,
        }

        local kopts = { noremap = true, silent = true }

        vim.api.nvim_set_keymap(
          'n',
          'n',
          [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
          kopts
        )

        vim.api.nvim_set_keymap(
          'n',
          'N',
          [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
          kopts
        )

        vim.api.nvim_set_keymap(
          'n',
          '*',
          [[*<Cmd>lua require('hlslens').start()<CR>]],
          kopts
        )

        vim.api.nvim_set_keymap(
          'n',
          '#',
          [[#<Cmd>lua require('hlslens').start()<CR>]],
          kopts
        )

        vim.api.nvim_set_keymap(
          'n',
          'g*',
          [[g*<Cmd>lua require('hlslens').start()<CR>]],
          kopts
        )

        vim.api.nvim_set_keymap(
          'n',
          'g#',
          [[g#<Cmd>lua require('hlslens').start()<CR>]],
          kopts
        )
      end,
    }

    use {
      'j-hui/fidget.nvim',
      config = function()
        require('fidget').setup {
          text = {
            spinner = 'dots',
          },
          window = {
            blend = 0,
          },
        }
      end,
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'nvim-treesitter/playground',
      },
      run = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
      end,
      config = function()
        require('nvim-treesitter.configs').setup {
          additional_vim_regex_highlighting = false,
          ensure_installed = {
            'comment',
            'css',
            'diff',
            'dockerfile',
            'fish',
            'git_rebase',
            'gitcommit',
            'gitignore',
            'help',
            'html',
            'javascript',
            'json5',
            'lua',
            'markdown',
            'markdown_inline',
            'proto',
            'query',
            'rust',
            'toml',
            'tsx',
            'typescript',
            'vim',
            'yaml',
          },
          highlight = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<c-space>',
              node_incremental = '<c-space>',
              scope_incremental = '<c-s>',
              node_decremental = '<c-backspace>',
            },
          },
          indent = { enable = true },
          playground = {
            enable = true,
          },
        }
      end,
    }

    use {
      'nvim-treesitter/nvim-treesitter-context',
      config = function()
        require('treesitter-context').setup {
          patterns = {
            css = {
              'block',
            },
          },
        }
      end,
    }

    use {
      'nmac427/guess-indent.nvim',
      config = function()
        require('guess-indent').setup {}
      end,
    }

    use {
      'JoosepAlviste/nvim-ts-context-commentstring',
      config = function()
        require('nvim-treesitter.configs').setup {
          context_commentstring = {
            enable = true,
            enable_autocmd = false,
          },
        }
      end,
    }

    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup {
          pre_hook = require(
            'ts_context_commentstring.integrations.comment_nvim'
          ).create_pre_hook(),
        }
      end,
    }

    use {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('telescope').setup {
          extensions = {
            ['ui-select'] = {
              require('telescope.themes').get_cursor(),
            },
          },
        }

        local builtin = require 'telescope.builtin'
        local extensions = require('telescope').extensions

        vim.keymap.set('n', '<leader>fb', function()
          builtin.buffers {
            ignore_current_buffer = true,
            sort_mru = true,
          }
        end, {
          desc = '[F]ind [B]uffers',
        })

        vim.keymap.set('n', '<leader>ff', builtin.find_files, {
          desc = '[F]ind [F]iles',
        })

        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {
          desc = '[F]ind [H]elp',
        })

        vim.keymap.set('n', '<leader>lg', builtin.live_grep, {
          desc = '[L]ive [G]rep',
        })

        vim.keymap.set('n', '<leader>fk', builtin.keymaps, {
          desc = '[F]ind [K]eymaps',
        })

        vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {
          desc = '[F]ind [O]ld files',
        })

        vim.keymap.set('n', '<leader>gb', builtin.git_branches, {
          desc = '[G]it [B]ranches',
        })

        vim.keymap.set('n', '<leader>gc', builtin.git_commits, {
          desc = '[G]it [C]ommits',
        })

        vim.keymap.set('n', '<leader>gf', builtin.git_files, {
          desc = '[G]it [F]iles',
        })

        vim.keymap.set('n', '<leader>gs', builtin.git_status, {
          desc = '[G]it [S]tatus',
        })

        vim.keymap.set(
          'n',
          '<leader>fs',
          extensions['session-lens'].search_session,
          {
            desc = '[F]ind [S]essions',
          }
        )
      end,
    }

    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
      cond = vim.fn.executable 'make' == 1,
      config = function()
        pcall(require('telescope').load_extension, 'fzf')
      end,
    }

    use {
      'nvim-telescope/telescope-ui-select.nvim',
      config = function()
        require('telescope').load_extension 'ui-select'
      end,
    }

    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup {
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            map('n', ']c', function()
              if vim.wo.diff then
                return ']c'
              end

              vim.schedule(function()
                gs.next_hunk()
              end)
              return '<Ignore>'
            end, { expr = true })

            map('n', '[c', function()
              if vim.wo.diff then
                return '[c'
              end

              vim.schedule(function()
                gs.prev_hunk()
              end)
              return '<Ignore>'
            end, { expr = true })

            map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
            map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
            map('n', '<leader>hS', gs.stage_buffer)
            map('n', '<leader>hu', gs.undo_stage_hunk)
            map('n', '<leader>hR', gs.reset_buffer)
            map('n', '<leader>hp', gs.preview_hunk)

            map('n', '<leader>hb', function()
              gs.blame_line { full = true }
            end)

            map('n', '<leader>tb', gs.toggle_current_line_blame)
            map('n', '<leader>hd', gs.diffthis)

            map('n', '<leader>hD', function()
              gs.diffthis '~'
            end)

            map('n', '<leader>td', gs.toggle_deleted)

            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
          end,
        }
      end,
    }

    use {
      'ethanholz/nvim-lastplace',
      config = function()
        require('nvim-lastplace').setup {
          lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
          lastplace_ignore_filetype = { 'gitcommit', 'gitrebase' },
          lastplace_open_folds = true,
        }
      end,
    }

    if is_bootstrap then
      require('packer').sync()
    end
  end,

  config = {
    display = {
      open_fn = require('packer.util').float,
    },
  },
}
