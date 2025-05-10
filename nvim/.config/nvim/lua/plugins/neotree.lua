return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    lazy = false,
    opts = {
        filesystem = {
            filtered_items = {
                visible = true,          -- Show hidden files
                hide_dotfiles = false,   -- Do not hide dotfiles
                hide_gitignored = false, -- Optional
            },
        },
    },
}
