return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
		require("tokyonight").setup({
			options = {
				transparent = true,
			},
		})

		vim.cmd("colorscheme tokyonight-night")
	end,
}