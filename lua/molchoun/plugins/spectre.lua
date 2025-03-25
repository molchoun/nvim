return {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local spectre = require("spectre")

        vim.keymap.set("n", "<leader>ssr", function()
            spectre.open()
        end, { desc = "Replace in files (Spectre)" })

        vim.keymap.set("n", "<leader>ssw", function()
            spectre.open_visual({ select_word = true })
        end, { desc = "Replace word under cursor" })

        vim.keymap.set("v", "<leader>ssw", function()
            spectre.open_visual()
        end, { desc = "Search and replace in selection" })
    end,
}

