return {
	-- Go forward/backward with square brackets
	{
		"echasnovski/mini.bracketed",
		event = "BufReadPost",
		config = function()
			local bracketed = require("mini.bracketed")
			bracketed.setup({
				file = { suffix = "" },
				window = { suffix = "" },
				quickfix = { suffix = "" },
				yank = { suffix = "" },
				treesitter = { suffix = "n" },
			})
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true, -- enable Treesitter check for better behavior
			})

			-- Optional: integration with nvim-cmp
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp_status_ok, cmp = pcall(require, "cmp")
			if cmp_status_ok then
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end
		end,
	},

	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					-- null_ls.builtins.diagnostics.mypy,
					-- null_ls.builtins.diagnostics.ruff,
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.code_actions.impl,
				},
			})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},

	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle)
			vim.keymap.set("n", "<leader>uf", vim.cmd.UndotreeFocus)
		end,
	},
}

