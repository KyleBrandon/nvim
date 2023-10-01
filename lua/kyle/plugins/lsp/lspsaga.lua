return {
    "nvimdev/lspsaga.nvim",
    branch = "main",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
        local saga = require("lspsaga")

        saga.setup({
            -- keybinds for navigation in lspsaga window
            -- scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
            -- use enter to open file with definition preview
            -- definition = {
            --   edit = "o",
            -- },
            ui = {
                colors = {
                    normal_bg = "#022746",
                },
            },
        })
    end,
}
