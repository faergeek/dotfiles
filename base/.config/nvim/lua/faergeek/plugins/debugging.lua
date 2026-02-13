return {
  {
    'mfussenegger/nvim-dap',
    dependencies = { 'igorlfs/nvim-dap-view' },
    cmd = {
      'DapClearBreakpoints',
      'DapContinue',
      'DapDisconnect',
      'DapEval',
      'DapNew',
      'DapPause',
      'DapRestartFrame',
      'DapSetLogLevel',
      'DapShowLog',
      'DapStepInto',
      'DapStepOut',
      'DapStepOver',
      'DapTerminate',
      'DapToggleBreakpoint',
      'DapToggleRepl',
    },
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
          require('dap').list_breakpoints(false)
          vim.cmd 'botright cwindow'
        end,
      },
      {
        desc = 'Debug: Terminate',
        '<leader>dt',
        '<Cmd>DapTerminate<CR>',
      },
      {
        'q',
        '<Cmd>q<CR>',
        ft = 'dap-float',
      },
    },
    config = function()
      local dap = require 'dap'

      dap.adapters.gdb = {
        type = 'executable',
        command = 'gdb',
        args = {
          '--interpreter=dap',
          '--eval-command',
          'set print pretty on',
        },
      }

      dap.adapters['pwa-node'] = {
        executable = { command = 'js-debug-adapter' },
        host = 'localhost',
        port = '8123',
        type = 'server',
      }

      dap.defaults.fallback.switchbuf = 'usetab,newtab'
      dap.providers.configs['dap.launch.json'] = nil

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
  {
    'igorlfs/nvim-dap-view',
    cmd = {
      'DapViewClose',
      'DapViewJump',
      'DapViewNavigate',
      'DapViewOpen',
      'DapViewShow',
      'DapViewToggle',
      'DapViewWatch',
    },
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {
      auto_toggle = true,
      follow_tab = true,
      winbar = {
        default_section = 'repl',
      },
    },
  },
}
