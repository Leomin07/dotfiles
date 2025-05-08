-- Tabs & indentation
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.tabstop = 2           -- Number of spaces a <Tab> counts for
vim.opt.softtabstop = 2        -- Number of spaces a <Tab> feels like in insert mode
vim.opt.shiftwidth = 2         -- Number of spaces used for autoindent

-- General UI
vim.opt.number = true          -- Show absolute line number
vim.opt.relativenumber = true  -- Show relative line numbers
vim.opt.cursorline = true      -- Highlight the line with the cursor
vim.opt.hlsearch = true        -- Highlight search results
vim.opt.incsearch = true       -- Show match while typing

-- Highlight line numbers above/below the cursor
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "white" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ead84e" })

-- System clipboard integration (use + register)
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard (not just "unnamed")

-- Move selected lines up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

