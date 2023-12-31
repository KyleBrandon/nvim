return {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = {
        "mfussenegger/nvim-dap",
        "theHamsta/nvim-dap-virtual-text",
        "mxsdev/nvim-dap-vscode-js",
        -- lazy spec to build "microsoft/vscode-js-debug" from source
        {
            "microsoft/vscode-js-debug",
            version = "1.x",
            build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
        },
        "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local dap_vscode = require("dap-vscode-js")
        dap_vscode.setup({
            debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
            adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
        })

        for _, language in ipairs({ "typescript", "javascript" }) do
            dap.configurations[language] = {
                -- attach to a node process that has been started with
                -- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
                -- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
                {
                    -- use nvim-dap-vscode-js's pwa-node debug adapter
                    type = "pwa-node",
                    -- attach to an already running node process with --inspect flag
                    -- default port: 9222
                    request = "attach",
                    -- allows us to pick the process using a picker
                    processId = require("dap.utils").pick_process,
                    -- name of the debug action
                    name = "Attach debugger to existing `node --inspect` process",
                    -- for compiled languages like TypeScript or Svelte.js
                    sourceMaps = true,
                    -- resolve source maps in nested locations while ignoring node_modules
                    resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
                    -- path to src in vite based projects (and most other projects as well)
                    cwd = "${workspaceFolder}/src",
                    -- we don't want to debug code inside node_modules, so skip it!
                    skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
                },
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Debug Jest Tests",
                    -- trace = true, -- include debugger info
                    runtimeExecutable = "node",
                    runtimeArgs = {
                        "./node_modules/jest/bin/jest.js",
                        "--runInBand",
                    },
                    rootPath = "${workspaceFolder}",
                    cwd = "${workspaceFolder}",
                    console = "integratedTerminal",
                    internalConsoleOptions = "neverOpen",
                },
                {
                    type = "pwa-chrome",
                    name = "Launch Chrome to debug client",
                    request = "launch",
                    url = "http://localhost:3000",
                    sourceMaps = true,
                    protocol = "inspector",
                    port = 9222,
                    webRoot = "${workspaceFolder}/src",
                    -- skip files from vite's hmr
                    skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
                },
                -- only if language is javascript, offer this debug action
                language == "javascript"
                        and {
                            -- use nvim-dap-vscode-js's pwa-node debug adapter
                            type = "pwa-node",
                            -- launch a new process to attach the debugger to
                            request = "launch",
                            -- name of the debug action you have to select for this config
                            name = "Launch file in new node process",
                            -- launch current file
                            program = "${file}",
                            cwd = "${workspaceFolder}",
                        }
                    or nil,
            }
        end

        -- Configure the UI
        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({ reset = true })
        end

        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end

        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- Configure Mason Nvim DAP
        require("mason-nvim-dap").setup()
    end,
    keys = {
        {
            "<leader>db",
            function()
                require("dap").toggle_breakpoint()
            end,
        },
        {
            "<leader>dc",
            function()
                require("dap").continue()
            end,
        },
        {
            "<leader>dr",
            function()
                require("dap").open({ reset = true })
            end,
        },
        {
            "<C-'>",
            function()
                require("dap").step_over()
            end,
        },
        {
            "<C-;>",
            function()
                require("dap").step_into()
            end,
        },
        {
            "<C-:>",
            function()
                require("dap").step_out()
            end,
        },
    },
}
