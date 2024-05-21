return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      {
        desc = 'Debug: Breakpoint Toggle',
        '<leader>db',
        function() require('dap').toggle_breakpoint() end,
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
        function() require('dap').continue() end,
      },
      {
        desc = 'Debug: Toggle REPL',
        '<leader>dr',
        function() require('dap').repl.toggle() end,
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
        '<leader>do',
        function() require('dap').step_over() end,
        desc = 'Debug: Step Over',
      },
      {
        '<leader>di',
        function() require('dap').step_into() end,
        desc = 'Debug: Step Into',
      },
      {
        '<leader>dO',
        function() require('dap').step_out() end,
        desc = 'Debug: Step Out',
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
        function() require('dap').terminate() end,
      },
    },
    dependencies = {
      {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = {
          'williamboman/mason.nvim',
        },
        cmd = { 'DapInstall', 'DapUninstall' },
        init = function()
          local name = 'dap'

          require('neoconf.plugins').register {
            name = name,
            on_schema = function(schema)
              schema:set(name, {
                type = 'object',
                properties = {
                  firefox = {
                    type = 'object',
                    properties = {
                      url = {
                        type = 'string',
                        default = 'http://localhost:8080',
                      },
                      webRoot = {
                        type = 'string',
                        default = '${workspaceFolder}',
                      },
                    },
                    required = { 'url', 'webRoot' },
                  },
                  node = {
                    type = 'object',
                    properties = {
                      cwd = {
                        type = 'string',
                        default = '${workspaceFolder}',
                      },
                      localRoot = {
                        type = 'string',
                        default = '${workspaceFolder}',
                      },
                      port = {
                        type = 'number',
                        default = 9229,
                      },
                      remoteRoot = {
                        type = 'string',
                        default = '${workspaceFolder}',
                      },
                    },
                  },
                },
              })
            end,
          }
        end,
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
