return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'marilari88/neotest-vitest',
      'nvim-neotest/neotest-jest',
      'thenbe/neotest-playwright',
    },
    cmd = {
      'Neotest',
      'NeotestPlaywrightProject',
      'NeotestPlaywrightRefresh',
    },
    keys = {
      {
        desc = 'Test: Run nearest',
        '<leader>tr',
        '<Cmd>Neotest run<CR>',
      },
      {
        desc = 'Test: Run file',
        '<leader>tR',
        function() require('neotest').run.run(vim.fn.expand '%') end,
      },
      {
        desc = 'Test: Watch nearest',
        '<leader>tw',
        function() require('neotest').watch.toggle() end,
      },
      {
        desc = 'Test: Watch file',
        '<leader>tW',
        function() require('neotest').watch.toggle(vim.fn.expand '%') end,
      },
      {
        desc = 'Test: Output',
        '<leader>to',
        '<Cmd>Neotest output<CR>',
      },
      {
        desc = 'Test: Summary',
        '<leader>ts',
        '<Cmd>Neotest summary<CR>',
      },
      {
        ft = {
          'neotest-output',
          'neotest-output-panel',
          'neotest-summary',
        },
        'q',
        '<Cmd>q<CR>',
      },
      {
        desc = 'Test: Playwright Project',
        '<leader>tpp',
        '<Cmd>NeotestPlaywrightProject<CR>',
      },
      {
        desc = 'Test: Playwright Refresh',
        '<leader>tpr',
        '<Cmd>NeotestPlaywrightRefresh<CR>',
      },
      {
        desc = 'Test: Playwright Attachment',
        '<leader>tpa',
        function() require('neotest').playwright.attachment() end,
      },
    },
    opts = function()
      return {
        adapters = {
          require 'neotest-vitest',
          require 'neotest-jest',
          require('neotest-playwright').adapter {
            options = {
              enable_dynamic_test_discovery = true,
              persist_project_selection = true,
              preset = 'debug',
            },
          },
        },
        consumers = {
          playwright = require('neotest-playwright.consumers').consumers,
        },
        output = {
          open_on_run = false,
        },
      }
    end,
  },
}
