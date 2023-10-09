return {
    "mbbill/undotree",
    config = function()
        local keymap = vim.keymap -- for conciseness
        keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
}
