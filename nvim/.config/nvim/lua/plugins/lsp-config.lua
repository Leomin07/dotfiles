-- return {
--     {
--         "williamboman/mason.nvim",
--         -- version = "v1.11.0",
--         config = function()
--             require("mason").setup()
--         end,
--     },
--     {
--         "williamboman/mason-lspconfig.nvim",
--         lazy = false,
--         opts = {
--             auto_install = true,
--             -- manually install packages that do not exist in this list please
--             ensure_installed = {
--                 -- Lua
--                 "lua_ls",
--                 -- Zig
--                 -- "zls",
--                 -- TypeScript / JavaScript
--                 "ts_ls",
--                 -- HTML & CSS
--                 "html",
--                 "cssls",
--                 -- Python
--                 "pyright",
--                 -- JSON
--                 "jsonls",
--                 -- Markdown
--                 "marksman",
--                 -- C/C++
--                 "clangd",
--                 -- Tailwind CSS
--                 "tailwindcss",
--                 -- YAML
--                 "yamlls",
--                 -- Emmet
--                 "emmet_ls"
--             },
--         },
--     },
--     {
--         "neovim/nvim-lspconfig",
--         lazy = false,
--         config = function()
--             local capabilities = require("cmp_nvim_lsp").default_capabilities()
--             local lspconfig = require("lspconfig")
--             -- lua
--             lspconfig.lua_ls.setup({
--                 capabilities = capabilities,
--                 settings = {
--                     Lua = {
--                         diagnostics = {
--                             globals = { "vim", "require" },
--                         },
--                         workspace = {
--                             library = vim.api.nvim_get_runtime_file("", true),
--                             checkThirdParty = false,
--                         },
--                         telemetry = {
--                             enable = false,
--                         },
--                     },
--                 },
--             })
--             -- typescript
--             lspconfig.ts_ls.setup({
--                 capabilities = capabilities,
--             })
--             -- Js
--             lspconfig.eslint.setup({
--                 capabilities = capabilities,
--             })
--             -- zig
--             -- lspconfig.zls.setup({
--             --     capabilities = capabilities,
--             -- })
--             -- yaml
--             lspconfig.yamlls.setup({
--                 capabilities = capabilities,
--             })
--             -- tailwindcss
--             lspconfig.tailwindcss.setup({
--                 capabilities = capabilities,
--             })
--             -- protocol buffer
--             lspconfig.buf_ls.setup({ capabilities = capabilities })
--             -- docker compose
--             lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })
--             -- svelte
--             lspconfig.svelte.setup({ capabilities = capabilities })
--             vim.api.nvim_create_autocmd("FileType", {
--                 pattern = "proto",
--                 callback = function()
--                     lspconfig.buf_language_server.setup({
--                         capabilities = capabilities,
--                     })
--                 end,
--             })
--             -- python
--             lspconfig.pyright.setup({ capabilities = capabilities })
--             -- lspconfig.pylsp.setup({ capabilities = capabilities })
--             -- Emmet
--             lspconfig.emmet_ls.setup({
--                 capabilities = capabilities,
--                 filetypes = {
--                     "html",
--                     "css",
--                     "scss",
--                     "javascriptreact",
--                     "typescriptreact",
--                     "blade",
--                     "vue",
--                     "svelte",
--                 },
--                 init_options = {
--                     html = {
--                         options = {
--                             ["bem.enabled"] = true,
--                         },
--                     },
--                 },
--             })

--             -- lsp kepmap setting
--             vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
--             vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
--             vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
--             vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
--             vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
--             vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
--             vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
--             -- list all methods in a file
--             -- working with go confirmed, don't know about other, keep changing as necessary
--             vim.keymap.set("n", "<leader>fm", function()
--                 local filetype = vim.bo.filetype
--                 local symbols_map = {
--                     python = "function",
--                     javascript = "function",
--                     typescript = "function",
--                     -- java = "class",
--                     lua = "function",
--                     -- go = { "method", "struct", "interface" },
--                 }
--                 local symbols = symbols_map[filetype] or "function"
--                 require("fzf-lua").lsp_document_symbols({ symbols = symbols })
--             end, {})
--         end,
--     },

--     -- ************************************************************
--     -- VTSLS (TypeScript/JavaScript Language Server) Cấu hình
--     -- ************************************************************
--     {
--         "yioneko/nvim-vtsls",
--         lazy = false,
--         ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
--         -- No 'opts' initially, just to see if the plugin loads without a setup error
--     },

-- }
return {
    -- Mason: LSP server installer
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- Mason-lspconfig: Bridge giữa mason và lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
            ensure_installed = {
                "lua_ls",
                "vtsls", -- JavaScript/TypeScript/Vue/NestJS
                "html",
                "cssls",
                "pyright",
                "jsonls",
                "marksman",
                "clangd",
                "tailwindcss",
                "yamlls",
                "emmet_ls",
            },
        },
    },

    -- LSP config
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            -- Lua
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim", "require" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })

            -- JavaScript / TypeScript / Vue / React / NestJS
            lspconfig.vtsls.setup({
                capabilities = capabilities,
                settings = {
                    complete_function_calls = true,
                    vtsls = {
                        enableMoveToFileCodeAction = true,
                        autoUseWorkspaceTsdk = true,
                        experimental = {
                            enableProjectDiagnostics = false,
                            -- Giảm số lượng completion trả về để tránh lag
                            completion = {
                                enableServerSideFuzzyMatch = true,
                                entriesLimit = 100,
                            },
                            -- Tắt project-wide diagnostics nếu quá nặng
                            enableProjectDiagnostics = false,
                        },
                    },
                    typescript = {
                        updateImportsOnFileMove = { enabled = "always" },
                        suggest = {
                            completeFunctionCalls = true,
                        },
                        tsserver = {
                            -- Tăng bộ nhớ tối đa cho tsserver lên 8GB
                            -- maxTsServerMemory = 8192,
                            maxTsServerMemory = 3072,
                            -- Nếu đang gặp lỗi plugin, có thể vô hiệu hóa
                            globalPlugins = {}, -- hoặc nil nếu không dùng
                        },
                        preferences = {
                            includePackageJsonAutoImports = "off",
                            autoImportFileExcludePatterns = {
                                "**/node_modules/**",
                                "**/.next/**",
                                "**/dist/**",
                            },
                        },
                    },
                    javascript = {
                        suggest = {
                            completeFunctionCalls = true,
                        },
                    },
                },
            })

            -- HTML / CSS / JSON / YAML / Markdown
            lspconfig.html.setup({ capabilities = capabilities })
            lspconfig.cssls.setup({ capabilities = capabilities })
            lspconfig.jsonls.setup({ capabilities = capabilities })
            lspconfig.yamlls.setup({ capabilities = capabilities })
            lspconfig.marksman.setup({ capabilities = capabilities })

            -- Tailwind CSS
            lspconfig.tailwindcss.setup({ capabilities = capabilities })

            -- Python
            lspconfig.pyright.setup({ capabilities = capabilities })

            -- C/C++
            lspconfig.clangd.setup({ capabilities = capabilities })

            -- Emmet
            lspconfig.emmet_ls.setup({
                capabilities = capabilities,
                filetypes = {
                    "html", "css", "scss", "javascriptreact", "typescriptreact",
                    "blade", "vue", "svelte",
                },
                init_options = {
                    html = {
                        options = {
                            ["bem.enabled"] = true,
                        },
                    },
                },
            })

            -- LSP Keymaps (giống VSCode)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
            vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

            -- FZF: liệt kê function/method trong file
            vim.keymap.set("n", "<leader>fm", function()
                local filetype = vim.bo.filetype
                local symbols_map = {
                    python = "function",
                    javascript = "function",
                    typescript = "function",
                    lua = "function",
                }
                local symbols = symbols_map[filetype] or "function"
                require("fzf-lua").lsp_document_symbols({ symbols = symbols })
            end, { desc = "List functions in file" })

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                update_in_insert = false,
                severity_sort = true,
            })
        end,
    },

    -- VTSLS plugin (optional nếu bạn cài từ mason rồi)
    {
        "yioneko/nvim-vtsls",
        lazy = false,
        ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
    },
}
