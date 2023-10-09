return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "simrat39/rust-tools.nvim",
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
    },
    config = function()
        local lspconfig = require("lspconfig")

        -- import cmp-nvim-lsp plugin
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")

        local keymap = vim.keymap -- for conciseness

        -- enable keybinds only for when lsp server available
        local on_attach = function(client, bufnr)
            -- In this case, we create a function that lets us more easily define mappings specific
            -- for LSP related items. It sets the mode, buffer and description for us each time.
            local nmap = function(keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end

                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
            end

            -- set keybinds
            nmap("gf", "<cmd>Lspsaga finder<CR>", "Show definition, references")
            nmap("gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Got to declaration")
            nmap("gd", "<cmd>Lspsaga peek_definition<CR>", "See definition and make edits in window")
            nmap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation")
            nmap("<leader>ca", "<cmd>Lspsaga code_action<CR>", "See available code actions")
            nmap("<leader>rn", "<cmd>Lspsaga rename<CR>", "Smart rename")
            nmap("<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", "Show  diagnostics for line")
            nmap("<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show diagnostics for cursor")
            nmap("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Jump to previous diagnostic in buffer")
            nmap("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Jump to next diagnostic in buffer") --
            nmap("K", "<cmd>Lspsaga hover_doc<CR>", "Show documentation for what is under cursor")
            nmap("<leader>o", "<cmd>Lspsaga outline<CR>", "See outline on right hand side")

            nmap("<leader>rs", ":LspRestart<CR>", "Restart LSP")

            -- typescript specific keymaps (e.g. rename file and update imports)
            if client.name == "tsserver" then
                nmap("<leader>rf", ":TypescriptRenameFile<CR>", "Rename file and update imports")
                nmap("<leader>oi", ":TypescriptOrganizeImports<CR>", "Organize imports (not in youtube nvim video)")
                nmap("<leader>ru", ":TypescriptRemoveUnused<CR>", "Remove unused variables (not in youtube nvim video)")
            end
        end

        -- Enable the following language servers
        --   Add an entry for the language server that you want to configure. The key is the name of the language server.
        --   You can override the default settings by adding a 'settings' field to the server config.
        --   If you want to override the default filetypes that your language server will attach to you can
        --   define the property `filetypes` in the override table.
        local servers = {
            rust_analyzer = {
                tools = {
                    autoSetHints = true,
                    inlay_hints = {
                        show_parameter_hints = true,
                        parameter_hints_prefix = "",
                        other_hints_prefix = "",
                    },
                },
                checkOnSave = {
                    allFeatures = true,
                    overrideCommnad = {
                        "cargo",
                        "clippy",
                        "--workspace",
                        "--message-format=json",
                        "--all-targets",
                        "--all-features",
                        "--",
                        "-D",
                        "warnings",
                    },
                },
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                            loadOutDirsFromCheck = true,
                            runBuildScripts = true,
                        },
                        procMacro = {
                            enable = true,
                        },
                        inlay_hints = {
                            lifetimeElisionHints = {
                                enabled = true,
                                useParameterNames = true,
                            },
                        },
                        checkOnSave = {
                            command = "clippy",
                        },
                        assist = {
                            importEnforceGranularity = true,
                            importPrefix = "crate",
                        },
                    },
                },
            },
            tsserver = {},
            cssls = {},
            html = {},
            tailwindcss = {},
            emmet_ls = {
                filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
            },
            lua_ls = {
                settings = {
                    Lua = {
                        -- make the language server recognize "vim" global
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            -- make language server aware of runtime files
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },
            },
        }

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- add folding to capabilities
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        -- Change the Diagnostic symbols in the sign column (gutter)
        -- (not in youtube nvim video)
        local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- enable mason and configure icons
        mason.setup()

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = vim.tbl_keys(servers),
            automatic_installation = true,
        })

        for server_name, server_config in pairs(servers) do
            local settings = (server_config or {}).settings
            local filetypes = (server_config or {}).filetypes
            local tools = (server_config or {}).tools
            local checkOnSave = (server_config or {}).checkOnSave

            if server_name == "rust_analyzer" then
                require("rust-tools").setup({
                    tools = tools,
                    checkOnSave = checkOnSave,
                    server = {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = settings,
                        filetypes = filetypes,
                    },
                })
            else
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = settings,
                    filetypes = filetypes,
                })
            end
        end

        -- format buffer
        keymap.set("n", "<leader>f", vim.lsp.buf.format)
    end,
}
