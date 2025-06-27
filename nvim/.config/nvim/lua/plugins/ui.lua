return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					numbers = "none",
					close_command = "bdelete! %d",
					right_mouse_command = "bdelete! %d",
					left_mouse_command = "buffer %d",
					middle_mouse_command = nil,

					indicator = {
						icon = "▎",
						style = "icon",
					},

					buffer_close_icon = "󰅖",
					modified_icon = "%#DiagnosticHint#●%*",
					close_icon = "",
					show_buffer_close_icons = true,
					show_close_icon = true,

					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,

					offsets = {
						{
							filetype = "neo-tree",
							text = "󰙅 File Explorer",
							highlight = "Directory",
							text_align = "left",
						},
					},

					separator_style = "slant",
					always_show_bufferline = true,
					custom_areas = {
						left = function()
							local result = {}
							for _, buf in ipairs(vim.api.nvim_list_bufs()) do
								if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "modified") then
									table.insert(result, { text = " ● Unsaved", fg = "#f7768e" })
									break
								end
							end
							return result
						end,
					},
				},
			})
		end,
	},

	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	event = "VeryLazy",
	-- 	main = "ibl",
	-- 	---@module "ibl"
	-- 	---@type ibl.config
	-- 	opts = {},

	-- 	config = function()
	-- 		local highlight = {
	-- 			"RainbowRed",
	-- 			"RainbowYellow",
	-- 			"RainbowBlue",
	-- 			"RainbowOrange",
	-- 			"RainbowGreen",
	-- 			"RainbowViolet",
	-- 			"RainbowCyan",
	-- 		}

	-- 		local hooks = require("ibl.hooks")
	-- 		-- create the highlight groups in the highlight setup hook, so they are reset
	-- 		-- every time the colorscheme changes
	-- 		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	-- 			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	-- 			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	-- 			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	-- 			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	-- 			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	-- 			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	-- 			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
	-- 		end)

	-- 		require("ibl").setup({ indent = { highlight = highlight } })
	-- 	end,
	-- },

	{
		"hiphish/rainbow-delimiters.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = "rainbow-delimiters.strategy.global",
					vim = "rainbow-delimiters.strategy.local",
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = {
					"RainbowDelimiterViolet",
					"RainbowDelimiterBlue",
					"RainbowDelimiterCyan",
					"RainbowDelimiterGreen",
					"RainbowDelimiterYellow",
					"RainbowDelimiterOrange",
					"RainbowDelimiterRed",
				},
			}

			local colors = {
				Violet = "#ffd700",
				Blue = "#da70d6",
				Cyan = "#87cefa",
				Green = "#32cd32",
				Yellow = "#ffa500",
				Orange = "#00ced1",
				Red = "#ff69b4",
			}

			for name, hex in pairs(colors) do
				vim.api.nvim_set_hl(0, "RainbowDelimiter" .. name, { fg = hex })
			end
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			-- "NeogitOrg/neogit", -- Bỏ comment nếu bạn dùng Neogit
			-- "sindrets/diffview.nvim", -- Bỏ comment nếu bạn dùng Diffview
		},
		config = function()
			local function safe_require(name)
				local ok, mod = pcall(require, name)
				return ok and mod or nil
			end

			local neogit = safe_require("neogit")
			local diffview = safe_require("diffview")

			local function toggle_neogit()
				if not neogit then
					return
				end
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.bo[buf].filetype:find("^Neogit") then
						vim.api.nvim_win_close(win, false)
						return
					end
				end
				neogit.open({ kind = "tab" })
			end

			require("lualine").setup({
				options = {
					theme = "vscode",
					icons_enabled = true,
					globalstatus = true,
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					disabled_filetypes = { statusline = { "alpha", "dashboard", "neo-tree" } },
				},
				sections = {
					lualine_a = { { "mode", icon = "" } },
					lualine_b = {
						{
							"branch",
							icon = "",
							on_click = toggle_neogit,
							cond = function()
								return neogit ~= nil
							end,
						},
						{
							"diff",
							symbols = { added = " ", modified = " ", removed = " " },
							on_click = function()
								diffview.open()
							end,
						},
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
						},
					},
					lualine_c = {
						{
							"filename",
							path = 1,
							symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" },
						},
					},
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_c = { "filename" },
					lualine_x = { "location" },
				},
				extensions = { "neo-tree", "fugitive", "toggleterm", "lazy", "quickfix", "fzf" },
			})
		end,
	},
}
