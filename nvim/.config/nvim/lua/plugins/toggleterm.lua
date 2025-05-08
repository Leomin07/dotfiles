-- ~/.config/nvim/lua/plugins/toggleterm.lua
return {
  "akinsho/toggleterm.nvim",
  config = function()
    -- Cấu hình ToggleTerm
    require("toggleterm").setup({
      size = 20,  -- Kích thước terminal (số dòng)
      open_mapping = [[<c-\>]],  -- Phím tắt để mở terminal
      direction = "horizontal",  -- Mở terminal dưới dạng horizontal
      shading_factor = 2,  -- Độ mờ khi terminal mở dạng floating
      start_in_insert = true,  -- Mở terminal trong chế độ insert
    })

    -- Phím tắt để mở terminal
    vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { desc = "Toggle Terminal" })
    
    -- Phím tắt để đóng terminal
    vim.keymap.set("t", "<leader>q", "<C-\\><C-n>:q<CR>", { desc = "Close Terminal" })
  end,
}

