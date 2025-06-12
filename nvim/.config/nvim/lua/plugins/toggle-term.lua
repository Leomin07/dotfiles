return {
    "akinsho/toggleterm.nvim",
    config = function()
        -- Cấu hình ToggleTerm
        require("toggleterm").setup({
            size = 20,
            -- open_mapping = [[<c-\>]],
            direction = "horizontal",
            shading_factor = 2,
            start_in_insert = true,
        })
    end,
}
