return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "echasnovski/mini.icons" },
	opts = {},
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			-- winopts = {
			-- 	height = 0.85,
			-- 	width = 0.90,
			-- 	preview = {
			-- 		layout = "horizontal",
			-- 	},
			-- },
			fzf_colors = {
				true,
				bg = "-1",
				gutter = "-1",
			},
			-- keymap = {
			-- 	fzf = { ["ctrl-q"] = "select-all+accept" },
			-- },
			grep = {
				-- Similar to VS Code, respect .gitignore, show line numbers, no heading (handled by fzf-lua)
				-- --hidden is for hidden files/directories. Adjust if you don't want this by default.
				rg_opts = "--hidden --glob '!.git/*' --column --line-number --no-heading --color=always",
			},
			live_grep = {
				-- Inherits from `grep` above, but you can override here if needed
				-- For a VS Code feel, --hidden is crucial for a comprehensive search
				rg_opts = "--hidden --glob '!.git/*' --column --line-number --no-heading --color=always",
			},
		})
		vim.keymap.set("n", "<C-p>", fzf.files, { desc = "Find Files" })
		vim.keymap.set("n", "<leader>fg", fzf.grep, { desc = "Live Grep" })
		vim.keymap.set("n", "<leader>sf", function()
			require("fzf-lua").live_grep({
				rg_opts = "--hidden --glob '!.git/*' --column --line-number --no-heading --color=always -e",
			})
		end, { desc = "Live Grep includes hidden files" })
		vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
		vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "Help Tags" })
		vim.keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Recent Files" })
		vim.keymap.set("n", "<leader>fs", function()
			fzf.grep({ search = vim.fn.input("Grep For > ") })
		end, { desc = "FZF grep with input" })
		vim.keymap.set("n", "<C-f>", function()
			require("fzf-lua").blines()
		end, { desc = "Search in current buffer (fzf-lua)" })
	end,
}
