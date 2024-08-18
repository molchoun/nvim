return {
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup {
        marker_padding = true,
        comment_empty = true,
        comment_empty_trim_whitespace = true,
        create_mappings = true,
        line_mapping = '<leader>cl',
        operator_mapping = '<leader>c',
        comment_chunk_text_object = 'ic',
        hook = function()
          -- Example hook: update commentstring for Vue files using ts-context-commentstring
          if vim.api.nvim_buf_get_option(0, 'filetype') == 'vue' then
            require('ts_context_commentstring.internal').update_commentstring()
          end
        end,
      }
    end,
  }

