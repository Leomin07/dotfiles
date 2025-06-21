return {
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
            size = 20,
            -- open_mapping = [[<c-\>]],
            direction = "float",
            -- shading_factor = 2,
            start_in_insert = true,
        })
    end,
}
