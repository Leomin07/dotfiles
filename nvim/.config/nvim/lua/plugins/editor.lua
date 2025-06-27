return {
	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		-- opts will be merged with the parent spec
		opts = { use_diagnostic_signs = true },
	},

	-- {
	--     "folke/todo-comments.nvim",
	--     dependencies = { "nvim-lua/plenary.nvim" },
	--     event = "VeryLazy",
	--     opts = {},
	--     keys = {
	--         { "]t",         function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
	--         { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },

	--         -- Trouble integration
	--         { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Toggle Todo (Trouble)" },
	--         { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Filter Todo/Fix/Fixme (Trouble)" },

	--         -- FZF-lua integration
	--         {
	--             "<leader>st",
	--             function()
	--                 require("fzf-lua").grep({ search = "TODO", no_esc = true })
	--             end,
	--             desc = "Search TODOs (fzf-lua)"
	--         },
	--         {
	--             "<leader>sT",
	--             function()
	--                 require("fzf-lua").grep({ search = "TODO|FIX|FIXME", no_esc = true })
	--             end,
	--             desc = "Search TODO/FIX/FIXME (fzf-lua)"
	--         },
	--     },
	-- },

	-- Scrollbar with git & diagnostics indicators
	{
		"petertriho/nvim-scrollbar",
		event = "VeryLazy",
		config = function()
			require("scrollbar").setup()
		end,
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
          -- stylua: ignore
          keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
          },
	},
}
