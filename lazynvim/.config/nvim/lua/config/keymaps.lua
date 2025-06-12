-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
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

-- Terminal
-- Open terminal
map("n", "<F5>", function()
  local filetype = vim.bo.filetype
  local filepath = vim.fn.expand("%")
  local filename = vim.fn.expand("%:t:r") -- tên file không đuôi
  local dir = vim.fn.expand("%:p:h")      -- thư mục chứa file

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
    require("toggleterm.terminal").Terminal
      :new({ cmd = run, direction = "float", close_on_exit = false })
      :toggle()
  else
    vim.notify("No run command defined for filetype: " .. filetype, vim.log.levels.WARN)
  end
end, { desc = "Run current file with <F5>" })

