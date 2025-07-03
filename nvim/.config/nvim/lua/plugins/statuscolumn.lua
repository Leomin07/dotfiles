return {
	{
		"luukvbaal/statuscol.nvim",
		branch = "0.10",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				relculright = true,
				segments = {
					-- Number lines
					{
						text = { builtin.lnumfunc, " " },
						colwidth = 1,
						click = "v:lua.ScLa",
					},
					-- Fold icon
					{
						text = { builtin.foldfunc, " " },
						hl = "FoldColumn",
						wrap = true,
						colwidth = 1,
						click = "v:lua.ScFa",
					},
					-- Diagnostic icon (custom)
					{
						text = {
							function(args)
								local icon = "  "
								local diags = vim.diagnostic.get(0, { lnum = args.lnum - 1 })
								if #diags > 0 then
									local severity = diags[1].severity
									if severity == vim.diagnostic.severity.ERROR then
										icon = " " -- nf-md-close
									elseif severity == vim.diagnostic.severity.WARN then
										icon = " "
									elseif severity == vim.diagnostic.severity.INFO then
										icon = " "
									elseif severity == vim.diagnostic.severity.HINT then
										icon = "󰌵 "
									end
								end
								return icon
							end,
						},
						colwidth = 2,
					},
					-- {
					-- 	text = {
					-- 		function(args)
					-- 			args.fold.close = " "
					-- 			args.fold.open = " "
					-- 			args.fold.sep = "▕ "
					-- 			return builtin.foldfunc(args)
					-- 		end,
					-- 	},
					-- 	click = "v:lua.ScFa",
					-- },
				},
			})
		end,
	},
}
