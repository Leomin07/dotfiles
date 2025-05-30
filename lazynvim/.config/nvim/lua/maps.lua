vim.g.mapleader = " "

local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = true
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Save
map("n", "<leader>w", "<CMD>update<CR>")

-- Quit
-- map("n", "<leader>q", "<CMD>q<CR>")

-- Exit insert mode
map("i", "jk", "<ESC>")

-- NeoTree
map("n", "<F5>", "<CMD>Neotree toggle<CR>")
map("n", "<leader>r", "<CMD>Neotree focus<CR>")

-- New Windows
map("n", "<leader>o", "<CMD>vsplit<CR>")
map("n", "<leader>p", "<CMD>split<CR>")
map("n", "<leader>q", "<CMD>close<CR>", { desc = "Close Current Window" })

-- Window Navigation
-- map("n", "<C-h>", "<C-w>h")
-- map("n", "<C-l>", "<C-w>l")
-- map("n", "<C-k>", "<C-w>k")
-- map("n", "<C-j>", "<C-w>j")

-- Resize Windows
-- map("n", "<C-Left>", "<C-w><")
-- map("n", "<C-Right>", "<C-w>>")
-- map("n", "<C-Up>", "<C-w>+")
-- map("n", "<C-Down>", "<C-w>-")

-- Telescope
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>", {
    desc = "Fuzzy find files in cwd"
})
map("n", "<leader>fg", "<CMD>Telescope live_grep<CR>", {
    desc = "Find string in cwd"
})
map("n", "<leader>fb", "<CMD>Telescope buffers<CR>", {
    desc = "Fuzzy find opened files"
})
-- map("n", "<leader>fs", "Telescope git_status<CR>", {
--     desc = "Show git file diffs"
-- })
-- map("n", "<leader>fc", "Telescope git_commits<CR>", {
--     desc = "Browse git commits"
-- })

-- Terminal
-- Open terminal
map("n", "<leader>t", "<CMD>ToggleTerm<CR>", { desc = "Toggle Terminal" })
-- Close terminal
-- Phím tắt để đóng terminal
map("t", "<leader>q", "<C-\\><C-n>:q<CR>", { desc = "Close Terminal" })
