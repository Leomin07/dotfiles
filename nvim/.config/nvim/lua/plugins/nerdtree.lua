return {
  -- Cài đặt plugin NERDTree
  {
    "preservim/nerdtree",
    cmd = "NERDTreeToggle",  -- Chỉ tải khi sử dụng lệnh NERDTree
    config = function()
      -- Cấu hình tùy chỉnh cho NERDTree
      vim.g.NERDTreeShowHidden = 1  -- Hiển thị các file ẩn
      vim.g.NERDTreeDirArrowExpandable = "▶"
      vim.g.NERDTreeDirArrowCollapsible = "▼"
    end,
  },
  -- Mở hoặc đóng NERDTree
   vim.keymap.set("n", "<leader>e", ":NERDTreeToggle<CR>", { desc = "Toggle NERDTree" })

}
