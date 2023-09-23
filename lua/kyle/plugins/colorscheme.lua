return {
    "bluz71/vim-nightfly-guicolors",
    name = "nightfly",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        -- require("nightfly").setup({
        --     disable_background = true,
        -- })
        -- Lua initialization file
        vim.g.nightflyTransparent = true

        vim.cmd([[colorscheme nightfly]])
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
}
