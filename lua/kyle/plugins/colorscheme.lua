return {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require("rose-pine").setup({
            disable_background = true,
        })

        vim.cmd([[colorscheme rose-pine]])
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
}
