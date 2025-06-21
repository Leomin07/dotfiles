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

                -- LSP
                { "<leader>l", group = { name = " LSP" } },
                { "<leader>li", "<cmd>LspInfo<CR>", desc = "LSP Info" },
                { "<leader>lr", vim.lsp.buf.rename, desc = "Rename Symbol" },
                { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },

                -- Comment
                { "<leader>/", desc = " Toggle Comment" },

                -- FZF
                { "<leader>f", group = { name = "󰈞 Find" } },
                { "<C-p>", function() require("fzf-lua").files() end, desc = "Find Files (fzf)" },
                { "<leader>fg", function() require("fzf-lua").grep() end, desc = "Grep (fzf)" },
                { "<leader>sf", function() require("fzf-lua").live_grep() end, desc = "Live Grep (fzf)" },
                { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers (fzf)" },
                { "<leader>fh", function() require("fzf-lua").help_tags() end, desc = "Help Tags (fzf)" },

                -- Git
                { "<leader>g", group = { name = " Git" } },
                { "<leader>gn", desc = " Neogit" },
                { "<leader>go", desc = "󰊢 Git Graph" },
                { "<leader>gh", desc = " Repo History" },
                { "<leader>gf", desc = "󰋚 File History" },
                { "<leader>gq", desc = "󰅖 Close Diffview" },

                -- Folds (UFO)
                { "<leader>z", group = { name = " Fold" } },
                { "<leader>zr", function() require("ufo").closeAllFolds() end, desc = "Close All Folds" },
                { "<leader>zm", function() require("ufo").openAllFolds() end, desc = "Open All Folds" },

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
                { "<C-w>", "<cmd>bd<CR>", desc = "Close Buffer" },
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

                -- Clipboard
                { "<C-c>", "+y", mode = "v", desc = "Copy to System Clipboard" },
                { "<C-v>", "+p", mode = "n", desc = "Paste from System Clipboard" },

                -- Undo / Redo
                { "<C-z>", "u", desc = "Undo", mode = { "n", "v" } },
                { "<C-z>", "<Esc>u", mode = "i", desc = "Undo (Insert Mode)" },
                { "<C-z>", "<C-\\><C-n>u", mode = "t", desc = "Undo (Terminal Mode)" },
                { "<C-S-z>", "<C-r>", desc = "Redo", mode = { "n", "v" } },
                { "<C-S-z>", "<Esc><C-r>", mode = "i", desc = "Redo (Insert Mode)" },
                { "<C-S-z>", "<C-\\><C-n><C-r>", mode = "t", desc = "Redo (Terminal Mode)" },

                -- Visual move blocks
                { "<S-A-Up>", "yyp", desc = "Copy Line Above", mode = "n" },
                { "<S-A-Down>", "yyP", desc = "Copy Line Below", mode = "n" },
                { "<S-A-Up>", "y`<P`>]", desc = "Copy Visual Above", mode = "v" },
                { "<S-A-Down>", "y`>p`<]", desc = "Copy Visual Below", mode = "v" },

                -- Open with system
                { "gx", desc = "Open with System App" },
            },
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "󰍉 Show Keymaps",
        },
        {
            "<c-w><space>",
            function()
                require("which-key").show({ keys = "<c-w>", loop = true })
            end,
            desc = "Window Hydra Mode",
        },
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        if not vim.tbl_isempty(opts.defaults) then
            LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
            wk.register(opts.defaults)
        end
    end,
}
