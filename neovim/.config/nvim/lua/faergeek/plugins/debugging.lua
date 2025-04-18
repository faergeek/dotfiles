return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      {
        desc = 'Debug: Breakpoint Toggle',
        '<leader>db',
        '<Cmd>DapToggleBreakpoint<CR>',
      },
      {
        desc = 'Debug: Breakpoint Condition',
        '<leader>dB',
        function()
          vim.ui.input(
            { prompt = 'Breakpoint condition: ' },
            function(condition)
              if not condition or condition == '' then return end

              require('dap').set_breakpoint(condition)
            end
          )
        end,
      },
      {
        desc = 'Debug: Log Point',
        '<leader>dl',
        function()
          vim.ui.input({ prompt = 'Log point message: ' }, function(message)
            if not message or message == '' then return end

            require('dap').set_breakpoint(nil, nil, message)
          end)
        end,
      },
      {
        desc = 'Debug: Continue',
        '<leader>dc',
        '<Cmd>DapContinue<CR>',
      },
      {
        desc = 'Debug: New',
        '<leader>dn',
        '<Cmd>DapNew<CR>',
      },
      {
        desc = 'Debug: Toggle REPL',
        '<leader>dr',
        '<Cmd>DapToggleRepl<CR>',
      },
      {
        desc = 'Debug: Hover',
        mode = { 'n', 'x' },
        '<leader>dh',
        function() require('dap.ui.widgets').hover(nil, { wrap = false }) end,
      },
      {
        desc = 'Debug: Step Over',
        '<leader>do',
        '<Cmd>DapStepOver<CR>',
      },
      {
        desc = 'Debug: Step Into',
        '<leader>di',
        '<Cmd>DapStepInto<CR>',
      },
      {
        desc = 'Debug: Step Out',
        '<leader>dO',
        '<Cmd>DapStepOut<CR>',
      },
      {
        desc = 'Debug: List All Breakpoints',
        '<leader>da',
        function()
          require('dap').list_breakpoints(true)
          vim.cmd.cwindow()
        end,
      },
      {
        desc = 'Debug: Terminate',
        '<leader>dt',
        '<Cmd>DapTerminate<CR>',
      },
    },
    dependencies = {
      {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = {
          'williamboman/mason.nvim',
        },
        cmd = { 'DapInstall', 'DapUninstall' },
        opts = {
          ensure_installed = { 'js' },
          handlers = {
            js = function()
              require('mason-nvim-dap').default_setup {
                adapters = {
                  executable = { command = 'js-debug-adapter' },
                  host = 'localhost',
                  port = '8123',
                  type = 'server',
                },
                name = 'pwa-node',
              }
            end,
          },
        },
      },
    },
    config = function()
      local dap = require 'dap'
      dap.defaults.fallback.switchbuf = 'usetab,newtab'

      vim.fn.sign_define {
        {
          text = '',
          name = 'DapBreakpoint',
          texthl = 'DapUIBreakpointsLine',
        },
        {
          text = '',
          name = 'DapBreakpointCondition',
          texthl = 'DapUIBreakpointsLine',
        },
        {
          text = '',
          name = 'DapLogPoint',
          texthl = 'DapUIBreakpointsLine',
        },
        {
          text = '',
          name = 'DapStopped',
          numhl = 'DapUIBreakpointsCurrentLine',
          texthl = 'DapUIBreakpointsCurrentLine',
        },
        {
          text = '',
          name = 'DapBreakpointRejected',
          texthl = 'DapUIBreakpointsDisabledLine',
        },
      }
    end,
  },
}
