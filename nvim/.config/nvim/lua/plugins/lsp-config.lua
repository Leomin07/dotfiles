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
--
return {
    -- Mason: LSP server installer
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        config = function()
            local servers = {
                "lua_ls",
                "vtsls",
                "html",
                "cssls",
                "pyright",
                "jsonls",
                "marksman",
                "clangd",
                "tailwindcss",
                "yamlls",
                "emmet_ls",
            }

            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_installation = true,
            })

            -- Auto install nếu thiếu
            local registry = require("mason-registry")
            for _, name in ipairs(servers) do
                local ok, pkg = pcall(registry.get_package, name)
                if ok and not pkg:is_installed() then
                    pkg:install()
                    vim.notify("🔧 Installing LSP: " .. name)
                end
            end
        end,
    },

    --LSP config
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
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })

            -- JS/TS/Vue/NestJS
            lspconfig.vtsls.setup({
                capabilities = capabilities,
                settings = {
                    vtsls = {
                        enableMoveToFileCodeAction = true,
                        autoUseWorkspaceTsdk = true,
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

            -- HTML/CSS/JSON/YAML
            for _, server in ipairs({ "html", "cssls", "jsonls", "yamlls" }) do
                lspconfig[server].setup({ capabilities = capabilities })
            end

            -- Markdown
            lspconfig.marksman.setup({ capabilities = capabilities })

            -- Tailwind
            lspconfig.tailwindcss.setup({ capabilities = capabilities })

            -- Python
            lspconfig.pyright.setup({ capabilities = capabilities })

            -- C/C++
            lspconfig.clangd.setup({ capabilities = capabilities })

            -- Emmet
            lspconfig.emmet_ls.setup({
                capabilities = capabilities,
                filetypes = {
                    "html", "css", "scss", "javascriptreact", "typescriptreact", "vue",
                },
                init_options = {
                    html = { options = { ["bem.enabled"] = true } },
                },
            })

            -- Keymap giống VSCode
            local map = vim.keymap.set
            map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
            map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
            map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
            map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
            map("n", "gr", vim.lsp.buf.references, { desc = "List References" })
            map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
            map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

            -- FZF tìm function
            map("n", "<leader>fm", function()
                require("fzf-lua").lsp_document_symbols({ symbols = "function" })
            end, { desc = "󰊕 List Functions (FZF)" })

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                update_in_insert = false,
                severity_sort = true,
            })
        end,
    },

    -- vtsls plugin
    {
        "yioneko/nvim-vtsls",
        lazy = false,
        ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
    },
}
