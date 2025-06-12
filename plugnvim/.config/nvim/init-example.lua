-- -- init.lua with vim-plug plugin list and settings (converted from .vim)

-- local vim = vim
-- local Plug = vim.fn['plug#']

-- -- Plugin list
-- vim.call('plug#begin', vim.fn.stdpath('config') .. '/plugged')

-- -- Theme
-- Plug('joshdick/onedark.vim')
-- Plug('akinsho/bufferline.nvim', { ['tag'] = '*' })
-- Plug('nvim-tree/nvim-web-devicons')

-- -- File browser
-- Plug('preservim/nerdTree')
-- Plug('Xuyuanp/nerdtree-git-plugin')
-- Plug('ryanoasis/vim-devicons')
-- Plug('unkiwii/vim-nerdtree-sync')
-- Plug('jcharum/vim-nerdtree-syntax-highlight', { ['branch'] = 'escape-keys' })

-- -- File search
-- Plug('junegunn/fzf', { ['do'] = function() vim.fn['fzf#install']() end })
-- Plug('junegunn/fzf.vim')

-- -- Status bar
-- Plug('vim-airline/vim-airline')
-- Plug('vim-airline/vim-airline-themes')

-- -- Terminal
-- Plug('voldikss/vim-floaterm')

-- -- Code intellisense
-- Plug('neoclide/coc.nvim', { ['branch'] = 'release' })
-- Plug('jiangmiao/auto-pairs')
-- Plug('mattn/emmet-vim')
-- Plug('preservim/nerdcommenter')
-- Plug('alvan/vim-closetag', {
--   ['do'] = 'yarn install --frozen-lockfile && yarn build',
--   ['branch'] = 'main'
-- })

-- -- Code syntax highlight
-- Plug('yuezk/vim-js')
-- Plug('MaxMEllon/vim-jsx-pretty')
-- Plug('jackguo380/vim-lsp-cxx-highlight')
-- Plug('sheerun/vim-polyglot')

-- -- Debugging
-- Plug('puremourning/vimspector')

-- -- Git integration
-- Plug('tpope/vim-fugitive')
-- Plug('tpope/vim-rhubarb')
-- Plug('airblade/vim-gitgutter')
-- Plug('samoshkin/vim-mergetool')

-- -- Fold
-- Plug('tmhedberg/SimpylFold')

-- -- Format
-- Plug('stevearc/conform.nvim')

-- vim.call('plug#end')

-- -- Theme
-- vim.cmd('silent! colorscheme onedark')

-- -- Source other .vim files from settings/ and config/
-- local function source_vim_files_from(dir)
--   local pattern = vim.fn.stdpath('config') .. '/' .. dir .. '/*.vim'
--   for _, file in ipairs(vim.fn.glob(pattern, 0, 1)) do
--     vim.cmd('source ' .. file)
--   end
-- end

-- source_vim_files_from('settings')
-- source_vim_files_from('config')

-- lua << EOF

-- require("conform").setup {
--   notify_on_error = false,
--   format_on_save = function(bufnr)
--     local disable_filetypes = { c = true, cpp = true }
--     if disable_filetypes[vim.bo[bufnr].filetype] then
--       return nil
--     else
--       return {
--         timeout_ms = 500,
--         lsp_format = 'fallback',
--       }
--     end
--   end,
--   formatters_by_ft = {
--     javascript = { "prettier" },
--     typescript = { "prettier" },
--     html = { "prettier" },
--     css = { "prettier" },
--     json = { "prettier" },
--     yaml = { "prettier" },
--     python = { "black" },
--     c = { "clang_format" },
--     cpp = { "clang_format" },
--     lua = { "stylua" },
--     sh = { "shfmt" },
--   },
-- }

-- vim.keymap.set({ "n", "v" }, "<leader>f", function()
--   require("conform").format({ async = true, lsp_fallback = true })
-- end, { desc = "[F]ormat buffer" })

-- EOF