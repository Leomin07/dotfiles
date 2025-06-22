return {

    -- Neogit (Git UI giống Magit)
    {
        "TimUntersberger/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = { "Neogit", "DiffviewOpen", "DiffviewFileHistory" },
        config = function()
            local neogit = require("neogit")
            neogit.setup({
                integrations = {
                    diffview = true,
                },
                disable_commit_confirmation = true,
                use_magit_keybindings = false,
                signs = {
                    section = { "", "" },
                    item = { "", "" },
                },
            })

            -- Toggle Neogit tab
            vim.keymap.set("n", "<leader>gn", function()
                local found = false
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    local name = vim.api.nvim_buf_get_name(buf)
                    if name:match("NeogitStatus") then
                        vim.cmd("tabclose")
                        found = true
                        break
                    end
                end
                if not found then
                    neogit.open({ kind = "tab" })
                end
            end, { desc = " Toggle Neogit (tab)" })
        end,
    },

    -- Diffview (hiển thị diff, history)
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy", -- hoặc BufReadPost nếu bạn muốn sớm hơn
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("diffview").setup({
                enhanced_diff_hl = true,
                use_icons = true,
                view = {
                    merge_tool = {
                        layout = "diff3_mixed",
                        disable_diagnostics = true,
                    },
                },
                file_panel = {
                    listing_style = "tree",
                    win_config = { position = "left", width = 35 },
                },
            })

            -- Mở Diffview UI
            vim.keymap.set("n", "<leader>go", "<cmd>DiffviewOpen<CR>", { desc = "󰊢 Open Git Graph" })

            -- Hiển thị history toàn repo
            vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory<CR>", { desc = " Repo History" })

            -- Hiển thị history của file hiện tại
            vim.keymap.set("n", "<leader>gf", function()
                local file = vim.fn.expand("%")
                vim.cmd("DiffviewFileHistory " .. file)
            end, { desc = "󰋚 File Git History" })

            -- Toggle đóng Diffview nếu đang mở
            vim.keymap.set("n", "<leader>gq", function()
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    local name = vim.api.nvim_buf_get_name(buf)
                    if name:match("^diffview://") then
                        vim.cmd("DiffviewClose")
                        return
                    end
                end
            end, { desc = "󰅖 Close Diffview if open" })
        end,
    },

}
