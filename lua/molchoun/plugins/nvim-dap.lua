local map = vim.keymap.set

local function get_python_venv_or_global()
  local current_dir = vim.fn.getcwd()
  local python_executable = nil

  while true do
    local venv_path = current_dir .. '/venv/bin/python'
    if vim.fn.executable(venv_path) == 1 then
      python_executable = venv_path
      break
    end

    local parent_dir = vim.fn.fnamemodify(current_dir, ':h')

    if parent_dir == current_dir then
      break
    end
    current_dir = parent_dir
  end

  -- vim.notify("Using python executable: " .. (python_executable or 'python'), vim.log.levels.INFO)
  return python_executable or 'python'
end

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',

    -- python debugger
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'debugpy',
      },
    }
    require('dap-python').setup(get_python_venv_or_global())
    -- Python specific setup
    dap.configurations.python = {
        {
            justMyCode = false,
            type = 'python',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            pythonPath = function()
            return get_python_venv_or_global()
            end,
        },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    map('n', '<F8>', dap.continue, { desc = 'Debug: Start/Continue' })
    map('n', '<F9>', dap.terminate, { desc = 'Debug: Terminate' })
    map('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    map('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    map('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    map('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    map('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    map('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
    dap.set_exception_breakpoints({"all"})

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://githu.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end,
}
