return {
  'ThePrimeagen/harpoon',

  config = function()
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'
    local map = vim.keymap.set

    map('n', '<leader>a', mark.add_file)
    map('n', '<C-e>', ui.toggle_quick_menu)

    map('n', '<leader>h', function()
      ui.nav_file(1)
    end)
    map('n', '<leader>j', function()
      ui.nav_file(2)
    end)
    map('n', '<leader>k', function()
      ui.nav_file(3)
    end)
    map('n', '<leader>l', function()
      ui.nav_file(4)
    end)
  end,
}
