return {
    -- Go forward/backward with square brackets
    {
        "echasnovski/mini.bracketed",
        event = "BufReadPost",
        config = function()
            local bracketed = require("mini.bracketed")
            bracketed.setup({
                file = { suffix = "" },
                window = { suffix = "" },
                quickfix = { suffix = "" },
                yank = { suffix = "" },
                treesitter = { suffix = "n" },
            })
        end,
    },

    {
        "windwp/nvim-ts-autotag",
        opts = {},
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true, -- enable Treesitter check for better behavior
            })

            -- Optional: integration with nvim-cmp
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp_status_ok, cmp = pcall(require, "cmp")
            if cmp_status_ok then
                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end
        end,
    },


    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle)
            vim.keymap.set("n", "<leader>uf", vim.cmd.UndotreeFocus)
        end,
    },

    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    }
}
