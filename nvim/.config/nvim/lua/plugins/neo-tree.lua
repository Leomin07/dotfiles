return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true, -- Hiện luôn file ẩn khi mở Neo-tree
					show_hidden_count = true,
					hide_dotfiles = false, -- Không ẩn dotfiles (.config, .git, ...)
					hide_gitignored = false,
				},
			},
		})

		vim.keymap.set("n", "<F5>", ":Neotree toggle<CR>", {})
	end,
}
