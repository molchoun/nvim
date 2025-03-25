return { -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  opts = {
    transparent = true,
    styles = {
      sidebars = 'transparent',
      floats = 'transparent',
    },
  },
  -- on_highlights = function(hl, c)
  --   hl.TelescopeNormal = {
  --     fg = c.fg_dark,
  --   }
  --   hl.TelescopeBorder = {
  --     fg = c.bg_dark,
  --   }
  --   hl.LineNr = {
  --     fg = '#DBDCDF',
  --   }
  --   hl.LineNrAbove = {
  --     fg = '#BFBFBF',
  --   }
  -- end,
  on_colors = function(colors)
    colors.fg_gutter = '#DBDCDF'
  end,
  init = function()
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.

    vim.cmd.colorscheme 'tokyonight'

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
    -- Change diagnostic color
    vim.cmd [[
        hi DiagnosticVirtualTextHint guifg=wheat
    ]]

    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#888888' })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = '#ff0000' })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#888888' })
  end,
}
