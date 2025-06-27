-- Foldtext
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.opt.foldcolumn = "auto:9"
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- highlights fold
function HighlightedFoldtext()
	local start = vim.v.foldstart
	local end_ = vim.v.foldend
	local folded_lines = end_ - start + 1

	local line = vim.api.nvim_buf_get_lines(0, start - 1, start, false)[1] or ""
	local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
	local parser = vim.treesitter.get_parser(0, lang)
	local query = vim.treesitter.query.get(parser:lang(), "highlights")

	if not query then
		return vim.fn.foldtext()
	end

	local tree = parser:parse({ start - 1, start })[1]
	local result = {}
	local line_pos = 0
	local prev_range = nil

	for id, node in query:iter_captures(tree:root(), 0, start - 1, start) do
		local name = query.captures[id]
		local srow, scol, erow, ecol = node:range()
		if srow == start - 1 and erow == start - 1 then
			local range = { scol, ecol }
			if scol > line_pos then
				table.insert(result, { line:sub(line_pos + 1, scol), "Folded" })
			end
			line_pos = ecol
			local text = vim.treesitter.get_node_text(node, 0)
			if prev_range and range[1] == prev_range[1] and range[2] == prev_range[2] then
				result[#result] = { text, "@" .. name }
			else
				table.insert(result, { text, "@" .. name })
			end
			prev_range = range
		end
	end

	if line_pos < #line then
		table.insert(result, { line:sub(line_pos + 1), "Folded" })
	end

	table.insert(result, { ("  ↙ %d  "):format(folded_lines), "FoldedCount" })

	return result
end

vim.api.nvim_set_hl(0, "FoldedCount", { fg = "#7aa2f7", bg = "NONE", italic = true, bold = true })

vim.opt.foldtext = [[luaeval('HighlightedFoldtext()')]]

