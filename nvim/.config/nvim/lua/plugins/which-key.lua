return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
        preset = "helix",
        defaults = {},
        spec = {
            {
                mode = { "n", "v" },

                -- Comment
                { "<leader>/", desc = " Toggle Comment" },


                -- Git
                { "<leader>g", group = { name = " Git" } },
                { "<leader>gn", desc = " Neogit" },
                { "<leader>go", desc = "󰊢 Git Graph" },
                { "<leader>gh", desc = " Repo History" },
                { "<leader>gf", desc = "󰋚 File History" },
                { "<leader>gq", desc = "󰅖 Close Diffview" },

                -- Folds (UFO)
                { "<leader>z", group = { name = " Fold" } },
                { "<leader>zc", function() require("ufo").closeAllFolds() end, desc = "Close All Folds" },
                { "<leader>za", function() require("ufo").openAllFolds() end, desc = "Open All Folds" },

                -- Terminal
                { "<leader>t", "<cmd>ToggleTerm<CR>", desc = " Toggle Terminal" },
                { "<C-t>k", function() require("toggleterm.terminal").Terminal:shutdown_all() end, desc = " Kill All Terminals" },

                -- File ops
                { "<leader>w", "<cmd>update<CR>", desc = " Save File" },
                { "<leader>qq", "<cmd>qa<CR>", desc = "󰗼 Quit All" },
                { "<leader>h", ":nohlsearch<CR>", desc = "󱎘 Clear Highlight" },

                -- Split
                { "<leader>o", "<cmd>vsplit<CR>", desc = " Vertical Split" },
                { "<leader>p", "<cmd>split<CR>", desc = " Horizontal Split" },

                -- Run file
                {
                    "<F6>",
                    function()
                        local filetype = vim.bo.filetype
                        local filepath = vim.fn.expand("%")
                        local filename = vim.fn.expand("%:t:r")
                        local cmd = {
                            python = "python3 " .. filepath,
                            javascript = "node " .. filepath,
                            typescript = "ts-node " .. filepath,
                            sh = "bash " .. filepath,
                            go = "go run " .. filepath,
                            c = string.format("gcc %s -o /tmp/%s && /tmp/%s", filepath, filename, filename),
                        }
                        local run = cmd[filetype]
                        if run then
                            require("toggleterm.terminal").Terminal:new({
                                cmd = run,
                                direction = "float",
                                close_on_exit = false,
                            }):toggle()
                        else
                            vim.notify("No run command for: " .. filetype, vim.log.levels.WARN)
                        end
                    end,
                    desc = " Run Current File",
                },

                -- Buffer & window navigation
                { "<C-w>", "<cmd>bd<CR>",                desc = "Close Buffer" },
                {
                    "<leader>b",
                    group = { name = "󰈙 Buffer" },
                    expand = function()
                        return require("which-key.extras").expand.buf()
                    end
                },
                {
                    "<leader>w",
                    group = { name = " Window" },
                    proxy = "<c-w>",
                    expand = function()
                        return require("which-key.extras").expand.win()
                    end
                },
                -- Open with system
                { "gx",    desc = "Open with System App" },
            },
        },
    },
    -- keys = {
    --     {
    --         "<leader>?",
    --         function()
    --             require("which-key").show({ global = false })
    --         end,
    --         desc = "󰍉 Show Keymaps",
    --     },
    --     {
    --         "<c-w><space>",
    --         function()
    --             require("which-key").show({ keys = "<c-w>", loop = true })
    --         end,
    --         desc = "Window Hydra Mode",
    --     },
    -- },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        if not vim.tbl_isempty(opts.defaults) then
            LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
            wk.register(opts.defaults)
        end
    end,
}
