vim.g.mapleader = " "

local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("force", { silent = true }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Save current file
map("n", "<leader>w", "<CMD>update<CR>")

-- Exit insert mode quickly
map("i", "jk", "<ESC>")

-- Vertical split
map("n", "<leader>o", "<CMD>vsplit<CR>")

-- Horizontal split
map("n", "<leader>p", "<CMD>split<CR>")

-- Close current buffer
map("n", "<C-w>", "<cmd>bd<cr>", { desc = "Close Current Buffer" })

-- Quit all files
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit All" })

-- Save file in normal mode
map("n", "<C-s>", "<cmd>w<CR>")

-- Save file in insert mode
map("i", "<C-s>", "<Esc><cmd>w<CR>")

-- Select all in normal mode
map("n", "<C-a>", "ggVG", { noremap = true })

-- Select all in insert mode
map("i", "<C-a>", "<Esc>ggVG", { noremap = true })

-- Clear search highlight
map("n", "<leader>h", ":nohlsearch<CR>")

-- Navigate windows: up
map("n", "<C-k>", "<C-w>k")

-- Navigate windows: down
map("n", "<C-j>", "<C-w>j")

-- Navigate windows: left
map("n", "<C-h>", "<C-w>h")

-- Navigate windows: right
map("n", "<C-l>", "<C-w>l")

-- Copy to system clipboard (visual mode)
map("v", "<C-c>", '"+y', { noremap = true })

-- Paste from system clipboard (normal mode)
map("n", "<C-v>", '"+p', { noremap = true })

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Undo (normal & visual mode)
map({ "n", "v" }, "<C-z>", "u", { desc = "Undo last change" })

-- Undo (insert mode)
map("i", "<C-z>", "<Esc>u", { desc = "Undo from Insert mode" })

-- Undo (terminal mode)
map("t", "<C-z>", "<C-\\><C-n>u", { desc = "Undo from Terminal mode" })

-- Redo (normal & visual mode)
map({ "n", "v" }, "<C-S-z>", "<C-r>", { desc = "Redo last undo" })

-- Redo (insert mode)
map("i", "<C-S-z>", "<Esc><C-r>", { desc = "Redo from Insert mode" })

-- Redo (terminal mode)
map("t", "<C-S-z>", "<C-\\><C-n><C-r>", { desc = "Redo from Terminal mode" })

-- Copy current line below (normal mode)
map("n", "<S-A-Down>", "yyP", { noremap = true })

-- Copy current line above (normal mode)
map("n", "<S-A-Up>", "yyp", { noremap = true })

-- Copy visual block below
map("v", "<S-A-Down>", "y`>p`<]", { noremap = true })

-- Copy visual block above
map("v", "<S-A-Up>", "y`<P`>]", { noremap = true })

-- Toggle terminal
map("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })

-- Hide terminal from terminal mode
map("t", "<leader>t", "<cmd>close<CR>", { desc = "Hide Terminal" })

-- Exit terminal mode
map("t", "<esc>", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })

-- Run current file based on filetype
map("n", "<F6>", function()
    local filetype = vim.bo.filetype
    local filepath = vim.fn.expand("%")
    local filename = vim.fn.expand("%:t:r")

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
        require("toggleterm.terminal").Terminal:new({
            cmd = run,
            direction = "float",
            close_on_exit = false,
        }):toggle()
    else
        vim.notify("No run command defined for filetype: " .. filetype, vim.log.levels.WARN)
    end
end, { desc = "Run current file with <F6>" })

