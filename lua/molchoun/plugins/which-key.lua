return { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      local mappings = {
        { '<leader>c', desc = '[C]ode' },
        { '<leader>d', desc = '[D]ocument' },
        { '<leader>h', desc = 'Git [H]unk' },
        { '<leader>r', desc = '[R]ename' },
        { '<leader>s', desc = '[S]earch' },
        { '<leader>t', desc = '[T]oggle' },
        { '<leader>w', desc = '[W]orkspace' },
      }

      require('which-key').add(mappings)

      -- Visual mode example with new spec
      require('which-key').add({
        { '<leader>h', desc = 'Git [H]unk' },
      }, { mode = 'v' })
    end,
  }

