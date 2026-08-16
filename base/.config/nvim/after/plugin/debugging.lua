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

dap.adapters.delve = function(callback, config)
  if config.mode == 'remote' and config.request == 'attach' then
    callback {
      type = 'server',
      host = config.host or '127.0.0.1',
      port = config.port or '38697',
    }
  else
    callback {
      type = 'server',
      port = '${port}',
      executable = {
        command = 'dlv',
        args = { 'dap', '-l', '127.0.0.1:${port}', '--log', '--log-output=dap' },
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end
end

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
    texthl = 'DapBreakpoint',
  },
  {
    text = '',
    name = 'DapBreakpointCondition',
    texthl = 'DapBreakpointCondition',
  },
  {
    text = '',
    name = 'DapLogPoint',
    texthl = 'DapLogPoint',
  },
  {
    text = '',
    name = 'DapStopped',
    numhl = 'DapStopped',
    texthl = 'DapStopped',
  },
  {
    text = '',
    name = 'DapBreakpointRejected',
    texthl = 'DapBreakpointRejected',
  },
}
