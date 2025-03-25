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

  vim.notify("Using python executable: " .. (python_executable or 'python'), vim.log.levels.INFO)
  return python_executable or 'python'
end

return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/neotest-python',
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
          runner = 'pytest',
          args = { '--log-level', 'DEBUG' },
          python = get_python_venv_or_global(),
          pytest_discover_instances = true,
        },
      },
    }
  end,
  keys = {
    {"<leader>t", "", desc = "+test"},
    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
    { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
    { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
    { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
    { "<leader>tR", function() require("neotest").run.run({ args = { "-s"}}) end, desc = "Run with -s (capture output)" },
  },
}
