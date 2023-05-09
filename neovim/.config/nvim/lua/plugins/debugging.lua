return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      {
        desc = '[D]ebug: [B]reakpoint Toggle',
        '<leader>db',
        function() require('dap').toggle_breakpoint() end,
      },
      {
        desc = '[D]ebug: [B]reakpoint Condition',
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
        desc = '[D]ebug: [L]og Point',
        '<leader>dl',
        function()
          vim.ui.input({ prompt = 'Log point message: ' }, function(message)
            if not message or message == '' then return end

            require('dap').set_breakpoint(nil, nil, message)
          end)
        end,
      },

      {
        desc = '[D]ebug: [C]ontinue',
        '<leader>dc',
        function() require('dap').continue() end,
      },
      {
        desc = 'Terminate',
        '<leader>dt',
        function() require('dap').terminate() end,
      },

      {
        '<leader>do',
        function() require('dap').step_over() end,
        desc = 'Debug: [S]tep over',
      },
      {
        '<leader>di',
        function() require('dap').step_into() end,
        desc = '[D]ebug: Step [I]nto',
      },
      {
        '<leader>dO',
        function() require('dap').step_out() end,
        desc = 'Debug: [S]tep out',
      },
    },
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        keys = {
          {
            desc = '[D]ebug: [T]oggle UI',
            '<leader>du',
            function() require('dapui').toggle() end,
          },
          {
            desc = '[D]ebug: [E]val',
            mode = { 'n', 'v' },
            '<leader>de',
            function() require('dapui').eval() end,
          },
          {
            desc = '[D]ebug: Reset sizes',
            '<leader>d=',
            function() require('dapui').open { reset = true } end,
          },
        },
        opts = {
          icons = { collapsed = '', current_frame = '', expanded = '' },
          layouts = {
            { position = 'bottom', size = 10, elements = { 'repl' } },
            {
              position = 'right',
              size = 40,
              elements = {
                { id = 'scopes', size = 0.5 },
                { id = 'breakpoints', size = 0.25 },
                { id = 'stacks', size = 0.25 },
              },
            },
          },
        },
        config = function(_, opts)
          local dap = require 'dap'
          local dapui = require 'dapui'
          local autocmd = require('utils').autocmd

          dapui.setup(opts)

          dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open()
          end

          dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close()
          end

          dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close()
          end

          autocmd(
            'Resize windows when terminal resizes',
            'VimResized',
            function() require('dapui').open { reset = true } end
          )
        end,
      },
      {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = {
          'williamboman/mason.nvim',
        },
        cmd = { 'DapInstall', 'DapUninstall' },
        opts = { automatic_installation = true },
      },
      {
        'mxsdev/nvim-dap-vscode-js',
        dependencies = {
          {
            'microsoft/vscode-js-debug',
            build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
          },
        },
        opts = {
          adapters = { 'pwa-node' },
          debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug',
        },
      },
      {
        'rcarriga/cmp-dap',
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = function()
          require('cmp').setup.filetype(
            { 'dap-repl', 'dapui_watches', 'dapui_hover' },
            {
              sources = {
                { name = 'dap' },
              },
            }
          )
        end,
      },
    },
    config = function()
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

      local dap = require 'dap'

      for _, language in ipairs {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      } do
        if not dap.configurations[language] then
          dap.configurations[language] = {}
        end

        table.insert(dap.configurations[language], {
          type = 'pwa-node',
          request = 'attach',
          name = 'Node: Attach',
          cwd = '${workspaceFolder}',
        })
      end
    end,
  },
}
