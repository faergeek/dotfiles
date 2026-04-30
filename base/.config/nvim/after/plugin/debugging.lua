require('dap-view').setup {
  auto_toggle = true,
  winbar = {
    default_section = 'repl',
  },
}

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

dap.adapters.godot = {
  type = 'server',
  host = '127.0.0.1',
  port = 6006,
}

dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    cb {
      type = 'server',
      port = (config.connect or config).port or 5678,
      host = (config.connect or config).host or '127.0.0.1',
      options = {
        source_filetype = 'python',
      },
    }
  else
    cb {
      type = 'executable',
      command = config.python,
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    }
  end
end

dap.adapters['pwa-node'] = {
  executable = { command = 'js-debug-adapter' },
  host = 'localhost',
  port = '8123',
  type = 'server',
}

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
