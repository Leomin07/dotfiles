return
{
    "kevinhwang91/nvim-ufo",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
        -- Setup keymaps
        vim.keymap.set("n", "za", require("ufo").openAllFolds, { desc = "Open all folds" })
        vim.keymap.set("n", "zc", require("ufo").closeAllFolds, { desc = "Close all folds" })

        -- Setup options
        vim.o.foldcolumn = "1"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true


        require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { 'treesitter', 'indent' }
            end,
        })
    end,
}
