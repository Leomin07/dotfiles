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
					"html",
					"css",
					"scss",
					"javascriptreact",
					"typescriptreact",
					"vue",
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

-- return {
-- 	-- Mason: LSP server installer
-- 	{
-- 		"williamboman/mason.nvim",
-- 		build = ":MasonUpdate",
-- 		config = function()
-- 			require("mason").setup()
-- 		end,
-- 	},

-- 	{
-- 		"williamboman/mason-lspconfig.nvim",
-- 		lazy = false,
-- 		config = function()
-- 			local servers = {
-- 				"lua_ls",
-- 				"ts_ls",
-- 				"html",
-- 				"cssls",
-- 				"pyright",
-- 				"jsonls",
-- 				"marksman",
-- 				"clangd",
-- 				"tailwindcss",
-- 				"yamlls",
-- 				"emmet_ls",
-- 			}

-- 			require("mason-lspconfig").setup({
-- 				ensure_installed = servers,
-- 				automatic_installation = true,
-- 			})

-- 			-- Auto install nếu thiếu
-- 			local registry = require("mason-registry")
-- 			for _, name in ipairs(servers) do
-- 				local ok, pkg = pcall(registry.get_package, name)
-- 				if ok and not pkg:is_installed() then
-- 					pkg:install()
-- 					vim.notify("🔧 Installing LSP: " .. name)
-- 				end
-- 			end
-- 		end,
-- 	},

-- 	--LSP config
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		lazy = false,
-- 		config = function()
-- 			local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- 			local lspconfig = require("lspconfig")

-- 			-- Lua
-- 			lspconfig.lua_ls.setup({
-- 				capabilities = capabilities,
-- 				settings = {
-- 					Lua = {
-- 						diagnostics = { globals = { "vim" } },
-- 						workspace = {
-- 							library = vim.api.nvim_get_runtime_file("", true),
-- 							checkThirdParty = false,
-- 						},
-- 						telemetry = { enable = false },
-- 					},
-- 				},
-- 			})

-- 			-- TypeScript/JavaScript (pmizio/typescript-tools)
-- 			require("typescript-tools").setup({
-- 				capabilities = capabilities,
-- 				settings = {
-- 					expose_as_code_action = "all",
-- 					tsserver_max_memory = auto,
-- 					tsserver_file_preferences = {
-- 						includeInlayParameterNameHints = "all",
-- 						includeInlayFunctionParameterTypeHints = true,
-- 						includeInlayVariableTypeHints = true,
-- 						includeInlayVariableTypeHintsWhenTypeMatchesName = false,
-- 						includeInlayPropertyDeclarationTypeHints = true,
-- 						includeInlayFunctionLikeReturnTypeHints = true,
-- 						includeInlayEnumMemberValueHints = true,
-- 						includePackageJsonAutoImports = "off",
-- 						autoImportFileExcludePatterns = {
-- 							"**/node_modules/**",
-- 							"**/.next/**",
-- 							"**/dist/**",
-- 						},
-- 						quotePreference = "auto",
-- 					},
-- 				},
-- 			})

-- 			-- HTML/CSS/JSON/YAML
-- 			for _, server in ipairs({ "html", "cssls", "jsonls", "yamlls" }) do
-- 				lspconfig[server].setup({ capabilities = capabilities })
-- 			end

-- 			-- Markdown
-- 			lspconfig.marksman.setup({ capabilities = capabilities })

-- 			-- Tailwind
-- 			lspconfig.tailwindcss.setup({ capabilities = capabilities })

-- 			-- Python
-- 			lspconfig.pyright.setup({ capabilities = capabilities })

-- 			-- C/C++
-- 			lspconfig.clangd.setup({ capabilities = capabilities })

-- 			-- Emmet
-- 			lspconfig.emmet_ls.setup({
-- 				capabilities = capabilities,
-- 				filetypes = {
-- 					"html",
-- 					"css",
-- 					"scss",
-- 					"javascriptreact",
-- 					"typescriptreact",
-- 					"vue",
-- 				},
-- 				init_options = {
-- 					html = { options = { ["bem.enabled"] = true } },
-- 				},
-- 			})

-- 			-- Keymap giống VSCode
-- 			local map = vim.keymap.set
-- 			map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
-- 			map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
-- 			map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
-- 			map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
-- 			map("n", "gr", vim.lsp.buf.references, { desc = "List References" })
-- 			map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
-- 			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- 			-- FZF tìm function
-- 			map("n", "<leader>fm", function()
-- 				require("fzf-lua").lsp_document_symbols({ symbols = "function" })
-- 			end, { desc = "󰊕 List Functions (FZF)" })

-- 			vim.diagnostic.config({
-- 				virtual_text = true,
-- 				signs = true,
-- 				update_in_insert = false,
-- 				severity_sort = true,
-- 			})
-- 		end,
-- 	},

-- 	-- pmizio/typescript-tools.nvim
-- 	{
-- 		"pmizio/typescript-tools.nvim",
-- 		lazy = false,
-- 		dependencies = {
-- 			"nvim-lua/plenary.nvim",
-- 			"neovim/nvim-lspconfig",
-- 		},
-- 		opts = {},

-- 	},
-- }
