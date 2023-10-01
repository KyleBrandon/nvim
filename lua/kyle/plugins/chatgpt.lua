return {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("chatgpt").setup({
            api_key_cmd = "op read op://dev/OpenAIAPIKey/password --no-newline",
            openai_params = {
                model = "gpt-3.5-turbo",
            },
        })
    end,
}
