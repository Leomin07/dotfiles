-- Set leader key
vim.g.mapleader = " "

-- Enable mouse
vim.opt.mouse = "a"

-- Clear search highlight with <leader>h
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Show absolute line numbers
vim.wo.number = true

-- Enable line wrap like VSCode
vim.opt.wrap = true

-- Enable spell checking
vim.opt.spell = true

-- Set UTF-8 encoding
vim.opt.encoding = "utf-8"

-- Enable absolute and relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tab and indentation settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Keep line wrap but disable automatic line breaking
vim.opt.formatoptions:remove("t")

-- Search settings: case insensitive unless uppercase used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Disable swap and backup files; enable persistent undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- Search UI behavior
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Enable 24-bit true color
vim.opt.termguicolors = true

-- Always show sign column
vim.opt.signcolumn = "yes"

-- Scroll context around cursor
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Allow @ character in file names
vim.opt.isfname:append("@-@")

-- Faster plugin response time
vim.opt.updatetime = 50

vim.opt.termguicolors = true

vim.o.mouse = "a"

-- Highlight search
vim.o.hlsearch = true
vim.o.incsearch = true

-- Show invisible characters (tabs, trailing spaces, etc.)
-- vim.opt.list = true
-- vim.opt.listchars = "tab:»·,extends:›,precedes:‹,nbsp:·,trail:·"

local opt = vim.opt
local cmd = vim.cmd
local api = vim.api
local nvim_create_autocmd = api.nvim_create_autocmd
local nvim_set_hl = api.nvim_set_hl

opt.list = true

local space = "·"
opt.listchars:append({
	tab = "│─",
	multispace = space,
	lead = space,
	trail = space,
	nbsp = space,
})

cmd([[match TrailingWhitespace /\s\+$/]])

nvim_set_hl(0, "TrailingWhitespace", { link = "Error" })

nvim_create_autocmd("InsertEnter", {
	callback = function()
		opt.listchars.trail = nil
		nvim_set_hl(0, "TrailingWhitespace", { link = "Whitespace" })
	end,
})

nvim_create_autocmd("InsertLeave", {
	callback = function()
		opt.listchars.trail = space
		nvim_set_hl(0, "TrailingWhitespace", { link = "Error" })
	end,
})


vim.diagnostic.config({
  severity_sort = true,
  virtual_text = {
    severity = { min = vim.diagnostic.severity.INFO }, -- Không hiện HINT
  },
  signs = {
    severity = { min = vim.diagnostic.severity.INFO }, -- Không hiện HINT
  },
  underline = {
    severity = { min = vim.diagnostic.severity.INFO }, -- Không hiện HINT
  },
  update_in_insert = false,
})