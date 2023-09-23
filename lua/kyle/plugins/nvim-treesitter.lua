return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        dependencies = {
            "windwp/nvim-ts-autotag",
        },
        config = function()
            -- import nvim-treesitter plugin
            local treesitter = require("nvim-treesitter.configs")

            -- configure treesitter
            treesitter.setup({ -- enable syntax highlighting
                highlight = {
                    enable = true,
                },
                -- enable indentation
                indent = { enable = true },
                -- enable autotagging (w/ nvim-ts-autotag plugin)
                autotag = { enable = true },
                -- ensure these language parsers are installed
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "css",
                    "dockerfile",
                    "gitignore",
                    "graphql",
                    "html",
                    "java",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "ruby",
                    "rust",
                    "svelte",
                    "tsx",
                    "typescript",
                    "vim",
                    "xml",
                    "yaml",
                },
                -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
                -- auto install above language parsers
                auto_install = true,
            })
        end,
    },
}
