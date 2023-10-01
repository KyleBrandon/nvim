return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            -- import nvim-treesitter plugin
            local treesitter = require("nvim-treesitter.configs")

            -- configure treesitter
            treesitter.setup({
                -- enable syntax highlighting
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "markdown" },
                },
                -- enable indentation
                indent = { enable = true },
                -- enable autotagging (w/ nvim-ts-autotag plugin)
                autotag = { enable = true },
                -- ensure these language parsers are installed
                ensure_installed = {
                    "json",
                    "javascript",
                    "typescript",
                    "rust",
                    "c",
                    "cpp",
                    "java",
                    "yaml",
                    "html",
                    "css",
                    "markdown",
                    "markdown_inline",
                    "bash",
                    "lua",
                    "vim",
                    "dockerfile",
                    "gitignore",
                },
                -- auto install above language parsers
                auto_install = true,
            })

        end,
    },
}
