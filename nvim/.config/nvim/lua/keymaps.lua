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
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")

-- System clipboard: copy, cut, paste
map({ "n", "v", "i" }, "<C-c>", function()
	if vim.fn.mode():match("[vV]") then
		vim.cmd('normal! "+y')
	else
		vim.cmd('normal! "+yy')
	end
end, { desc = "󰅍 Copy to clipboard" })

map({ "n", "v", "i" }, "<C-x>", function()
	if vim.fn.mode():match("[vV]") then
		vim.cmd('normal! "+d')
	else
		vim.cmd('normal! "+dd')
	end
end, { desc = "󰅎 Cut to clipboard" })

map({ "n", "v", "i" }, "<C-v>", '"+p', { desc = "󰅏 Paste from clipboard" })

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

-- Tab/Shift+Tab normal mode
vim.keymap.set("n", "<Tab>", ">>", { desc = "Indent line" })
vim.keymap.set("n", "<S-Tab>", "<<", { desc = "Outdent line" })

-- Replace char
vim.keymap.set("n", "<C-h>", function()
    -- Yêu cầu người dùng nhập chuỗi cần tìm kiếm
    local search_term = vim.fn.input("Search for (Ctrl+C to cancel): ")
    if search_term == "" then
        -- Người dùng nhấn Enter mà không nhập gì hoặc nhấn Ctrl+C để hủy
        print("Search cancelled.")
        return
    end

    -- Yêu cầu người dùng nhập chuỗi thay thế
    local replace_term = vim.fn.input("Replace with (leave empty for delete): ")
    -- Không cần kiểm tra replace_term rỗng vì thay thế bằng chuỗi rỗng là hợp lệ (xóa)

    -- Xây dựng lệnh thay thế cho file đang mở
    -- %s: Áp dụng thay thế cho toàn bộ file hiện tại (buffer đang mở)
    -- #: Dùng # làm ký tự phân cách thay vì / để tránh lỗi nếu search_term/replace_term chứa /
    -- g: Thay thế tất cả các lần xuất hiện trên mỗi dòng (global)
    -- i: Không phân biệt chữ hoa/thường (case-insensitive)
    -- c: Yêu cầu xác nhận cho mỗi lần thay thế (confirm)
    local command = string.format("%%s#%s#%s#gic", search_term, replace_term)

    -- Thực thi lệnh
    vim.cmd(command)
end, { desc = "Find and Replace (Whole Current File) with Prompt" })

-- Bạn cũng có thể map cho Visual mode để chỉ thay thế trong vùng chọn
vim.keymap.set("x", "<C-h>", function()
    local search_term = vim.fn.input("Search for (Ctrl+C to cancel): ")
    if search_term == "" then
        print("Search cancelled.")
        return
    end

    local replace_term = vim.fn.input("Replace with (leave empty for delete): ")

    -- '<,'>s: Thay thế trong vùng chọn Visual
    -- gic: global, case-insensitive, confirm
    local command = string.format("'<,'>s#%s#%s#gic", search_term, replace_term)
    vim.cmd(command)
end, { desc = "Find and Replace (Selection) with Prompt" })