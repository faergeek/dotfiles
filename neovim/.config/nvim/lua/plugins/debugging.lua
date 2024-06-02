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
        desc = 'Debug: Frames',
        '<leader>df',
        function() require('utils.dap').frames_sidebar.toggle() end,
      },
      {
        desc = 'Debug: Scopes',
        '<leader>ds',
        function() require('utils.dap').scopes_sidebar.toggle() end,
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
          ensure_installed = {
            'firefox',
          },
          handlers = {
            function(config) require('mason-nvim-dap').default_setup(config) end,
            firefox = function(config)
              local neoconf = require 'neoconf'

              config.configurations = {
                {
                  name = 'Firefox: Debug',
                  request = 'attach',
                  type = 'firefox',
                  url = function()
                    return neoconf.get('dap', { firefox = {} }).firefox.url
                  end,
                  webRoot = function()
                    return neoconf.get('dap', { firefox = {} }).firefox.webRoot
                  end,
                },
              }

              require('mason-nvim-dap').default_setup(config)
            end,
          },
        },
      },
      {
        'mxsdev/nvim-dap-vscode-js',
        dependencies = {
          {
            'microsoft/vscode-js-debug',
            build = table.concat({
              'echo 18.19.0 > .nvmrc',
              'npm i --ignore-scripts --legacy-peer-deps --no-audit --no-fund',
              'npx gulp vsDebugServerBundle',
              'rm -rf out',
              'mv dist out',
              'git checkout .',
            }, ' && '),
          },
        },
        opts = {
          adapters = { 'pwa-node' },
          debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug',
        },
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
      local neoconf = require 'neoconf'

      for _, language in ipairs {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      } do
        dap.configurations[language] = dap.configurations[language] or {}

        table.insert(dap.configurations[language], {
          name = 'Node: Debug',
          type = 'pwa-node',
          request = 'attach',
          cwd = function()
            local node = neoconf.get('dap', { node = {} }).node

            return node.cwd or node.localRoot or '${workspaceFolder}'
          end,
          localRoot = function()
            return neoconf.get('dap', { node = {} }).node.localRoot
          end,
          port = function() return neoconf.get('dap', { node = {} }).node.port end,
          remoteRoot = function()
            return neoconf.get('dap', { node = {} }).node.remoteRoot
          end,
        })
      end
    end,
  },
}
