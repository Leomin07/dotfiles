return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
  },
    config = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true, -- Hiển thị file ẩn
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    })

    -- Thêm phím tắt Toggle Neo-tree (ví dụ dùng F5)
    vim.keymap.set("n", "<F5>", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
  end,
}
