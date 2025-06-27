vim.g.mapleader = " "

-- Map helper with silent=true by default
local function map(mode, lhs, rhs, opts)
	opts = vim.tbl_extend("force", { silent = true }, opts or {})
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Save
map("n", "<leader>w", "<CMD>update<CR>")

-- Quick exit insert
-- map("i", "jk", "<ESC>")

-- Splits
map("n", "<leader>o", "<CMD>vsplit<CR>")
map("n", "<leader>p", "<CMD>split<CR>")

-- Close splits
map("n", "<leader>c", "<CMD>close<CR>", { desc = "Close Current Split" })
map("n", "<leader>co", "<CMD>only<CR>", { desc = "Close Other Splits" })

-- Close buffer / quit
map("n", "<C-w>", "<cmd>bd<cr>", { desc = "Close Current Buffer" })
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit All" })

-- Save
map("n", "<C-s>", "<cmd>w<CR>")
map("i", "<C-s>", "<Esc><cmd>w<CR>")

-- Select all
map("n", "<C-a>", "ggVG")
map("i", "<C-a>", "<Esc>ggVG")

-- Clear search
-- map("n", "<leader>h", ":nohlsearch<CR>")

-- Window nav
-- map("n", "<C-k>", "<C-w>k")
-- map("n", "<C-j>", "<C-w>j")
-- map("n", "<C-h>", "<C-w>h")
-- map("n", "<C-l>", "<C-w>l")

-- System clipboard: copy, cut, paste
map({ "n", "v" }, "<C-c>", function()
	if vim.fn.mode():match("[vV]") then
		vim.cmd('normal! "+y')
	else
		vim.cmd('normal! "+yy')
	end
end, { desc = "󰅍 Copy to clipboard" })

map({ "n", "v" }, "<C-x>", function()
	if vim.fn.mode():match("[vV]") then
		vim.cmd('normal! "+d')
	else
		vim.cmd('normal! "+dd')
	end
end, { desc = "󰅎 Cut to clipboard" })

map({ "n", "v" }, "<C-v>", '"+p', { desc = "󰅏 Paste from clipboard" })

vim.opt.clipboard = "unnamedplus"

-- Undo / Redo
map({ "n", "v" }, "<C-z>", "u", { desc = "Undo" })
map("i", "<C-z>", "<Esc>u", { desc = "Undo" })
map("t", "<C-z>", "<C-\\><C-n>u", { desc = "Undo" })

map({ "n", "v" }, "<C-S-z>", "<C-r>", { desc = "Redo" })
map("i", "<C-S-z>", "<Esc><C-r>", { desc = "Redo" })
map("t", "<C-S-z>", "<C-\\><C-n><C-r>", { desc = "Redo" })

-- Duplicate / move lines (Alt + Up/Down)
map("n", "<A-Up>", ":m .-2<CR>==", { desc = "󰜮 Move line up" })
map("n", "<A-Down>", ":m .+1<CR>==", { desc = "󰜯 Move line down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "󰜮 Move selection up" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "󰜯 Move selection down" })

-- Copy line up/down (Shift + Alt + Up/Down)
map("n", "<S-A-Up>", "yyp", { desc = "󰆐 Copy line above" })
map("n", "<S-A-Down>", "yyP", { desc = "󰆏 Copy line below" })
map("v", "<S-A-Up>", "y`<P`>]", { desc = "󰆐 Copy block above" })
map("v", "<S-A-Down>", "y`>p`<]", { desc = "󰆏 Copy block below" })

-- Terminal toggle
map("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
map("t", "<leader>t", "<cmd>close<CR>", { desc = "Hide Terminal" })
map("t", "<esc>", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })

-- Run current file with F6
map("n", "<F6>", function()
	local ft = vim.bo.filetype
	local file = vim.fn.expand("%")
	local bin = vim.fn.expand("%:t:r")

	local cmd = {
		python = "python3 " .. file,
		javascript = "node " .. file,
		typescript = "ts-node " .. file,
		sh = "bash " .. file,
		go = "go run " .. file,
		c = string.format("gcc %s -o /tmp/%s && /tmp/%s", file, bin, bin),
	}

	local run = cmd[ft]
	if run then
		require("toggleterm.terminal").Terminal
			:new({
				cmd = run,
				direction = "float",
				close_on_exit = false,
			})
			:toggle()
	else
		vim.notify("⚠ No run command for filetype: " .. ft, vim.log.levels.WARN)
	end
end, { desc = "󰑊 Run Current File" })

-- Delete current line (normal mode)
vim.keymap.set("n", "<C-S-k>", "dd", { noremap = true, desc = "Delete Line" })

-- Delete visual block (visual mode)
vim.keymap.set("v", "<C-S-k>", "d", { noremap = true, desc = "Delete Block" })

-- Duplicate current line (normal mode)
-- vim.keymap.set("n", "<C-d>", "yyp", { noremap = true, desc = "Duplicate Line" })

-- Duplicate visual block (visual mode)
vim.keymap.set("v", "<C-d>", "y`>p`<]", { noremap = true, desc = "Duplicate Block" })

--Tab/Shift Tab Visual mode
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent line(s)" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Outdent line(s)" })

--Tab/Shift+Tab normal mode
vim.keymap.set("n", "<Tab>", ">>", { desc = "Indent line" })
vim.keymap.set("n", "<S-Tab>", "<<", { desc = "Outdent line" })
