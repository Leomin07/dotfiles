local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("keymaps")
require("fold")

require("lazy").setup("plugins")

-- vim.diagnostic.config({
-- 	severity_sort = true,
-- 	virtual_text = {
-- 		severity = { min = vim.diagnostic.severity.INFO }, -- Không hiện HINT
-- 	},
-- 	signs = {
-- 		severity = { min = vim.diagnostic.severity.INFO }, -- Không hiện HINT
-- 	},
-- 	underline = {
-- 		severity = { min = vim.diagnostic.severity.INFO }, -- Không hiện HINT
-- 	},
-- 	-- update_in_insert = false,
-- })
