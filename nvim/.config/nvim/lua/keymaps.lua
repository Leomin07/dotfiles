vim.g.mapleader = " "

local function map(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.silent = true
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Save
map("n", "<leader>w", "<CMD>update<CR>")

-- Exit insert mode
map("i", "jk", "<ESC>")

-- New Windows
map("n", "<leader>o", "<CMD>vsplit<CR>")
map("n", "<leader>p", "<CMD>split<CR>")
map("n", "<leader>q", "<CMD>close<CR>", { desc = "Close Current Window" })

-- Terminal
-- Run code
map("n", "<F6>", function()
	local filetype = vim.bo.filetype
	local filepath = vim.fn.expand("%")
	local filename = vim.fn.expand("%:t:r") -- tên file không đuôi
	local dir = vim.fn.expand("%:p:h") -- thư mục chứa file

	local cmd = {
		python = "python3 " .. filepath,
		javascript = "node " .. filepath,
		typescript = "ts-node " .. filepath,
		sh = "bash " .. filepath,
		go = "go run " .. filepath,
		c = string.format("gcc %s -o /tmp/%s && /tmp/%s", filepath, filename, filename),
	}

	local run = cmd[filetype]
	if run then
		require("toggleterm.terminal").Terminal:new({ cmd = run, direction = "float", close_on_exit = false }):toggle()
	else
		vim.notify("No run command defined for filetype: " .. filetype, vim.log.levels.WARN)
	end
end, { desc = "Run current file with <F6>" })

-- Terminal Mappings
map("n", "<c-/>", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
map("t", "<esc>", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })

-- Navigate vim panes better
map("n", "<c-k>", ":wincmd k<CR>")
map("n", "<c-j>", ":wincmd j<CR>")
map("n", "<c-h>", ":wincmd h<CR>")
map("n", "<c-l>", ":wincmd l<CR>")

-- Save file
map("n", "<C-s>", "<cmd>w<CR>", opts)
map("i", "<C-s>", "<Esc><cmd>w<CR>", opts)

-- Quit
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit All" })

-- Normal mode
map("n", "<C-a>", "ggVG", { noremap = true, silent = true })

-- Insert mode
map("i", "<C-a>", "<Esc>ggVG", { noremap = true, silent = true })

vim.keymap.set("n", "<C-w>", "<cmd>bdelete<cr>", { desc = "Close Current Buffer" })