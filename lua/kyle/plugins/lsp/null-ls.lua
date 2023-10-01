return {
    "jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
    dependencies = {
        "jay-babu/mason-null-ls.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        -- import null-ls plugin
        local null_ls = require("null-ls")

        -- for conciseness
        local formatting = null_ls.builtins.formatting -- to setup formatters
        local diagnostics = null_ls.builtins.diagnostics -- to setup linters

        -- to setup format on save
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        -- configure null_ls
        null_ls.setup({
            -- setup formatters & linters
            sources = {
                --  to disable file types use
                --  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
                formatting.prettier,
                formatting.stylua,
                formatting.fixjson,
                diagnostics.eslint_d,
            },
            -- configure format on save
            on_attach = function(current_client, bufnr)
                if current_client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({
                                filter = function(client)
                                    --  only use null-ls for formatting instead of lsp server
                                    return client.name == "null-ls"
                                end,
                                bufnr = bufnr,
                            })
                        end,
                    })
                end
            end,
        })

        local mason_null_ls = require("mason-null-ls")

        mason_null_ls.setup({
            -- list of formatters & linters for mason to install
            ensure_installed = {
                "prettier", -- ts/js formatter
                "eslint_d", -- ts/js linter
            },
            -- auto-install configured formatters & linters (with null-ls)
            automatic_installation = true,
        })
    end,
}
