return {
    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        -- opts will be merged with the parent spec
        opts = { use_diagnostic_signs = true },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts_extend = { "spec" },
        opts = {
            preset = "helix",
            defaults = {},
            spec = {
                {
                    mode = { "n", "v" },
                    { "<leader><tab>", group = "tabs" },
                    { "<leader>c",     group = "code" },
                    { "<leader>/",     desc = "Toggle comment" },
                    { "<leader>d",     group = "debug" },
                    { "<leader>dp",    group = "profiler" },
                    { "<leader>f",     group = "file/find" },
                    { "<leader>ff",    function() require("fzf-lua").files() end,     desc = "Find Files (fzf)" },
                    { "<leader>fg",    function() require("fzf-lua").live_grep() end, desc = "Live Grep (fzf)" },
                    { "<leader>fb",    function() require("fzf-lua").buffers() end,   desc = "Buffers (fzf)" },
                    { "<leader>fh",    function() require("fzf-lua").help_tags() end, desc = "Help Tags (fzf)" },

                    -- git
                    {
                        "<leader>g", group = "git" },
                    { "<leader>gn", desc = " Neogit" },
                    { "<leader>go", desc = "󰊢 Git Graph" },
                    { "<leader>gh", desc = " Repo History" },
                    { "<leader>gf", desc = "󰋚 File History" },
                    { "<leader>gq", desc = "󰅖 Close Diffview" },

                    { "<leader>q", group = "quit/session" },
                    { "<leader>s", group = "search" },
                    { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
                    { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
                    { "[", group = "prev" },
                    { "]", group = "next" },
                    { "g", group = "goto" },
                    { "gs", group = "surround" },
                    { "z", group = "fold" },

                    {
                        "<leader>b",
                        group = "buffer",
                        expand = function()
                            return require("which-key.extras").expand.buf()
                        end,
                    },
                    {
                        "<leader>w",
                        group = "windows",
                        proxy = "<c-w>",
                        expand = function()
                            return require("which-key.extras").expand.win()
                        end,
                    },
                    { "gx", desc = "Open with system app" },
                },
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Keymaps (which-key)",
            },
            {
                "<c-w><space>",
                function()
                    require("which-key").show({ keys = "<c-w>", loop = true })
                end,
                desc = "Window Hydra Mode (which-key)",
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
    },



    {
        'numToStr/Comment.nvim',
        opts = {},
        lazy = false,
        config = function()
            local api = require('Comment.api')

            require('Comment').setup()

            -- Toggle comment (Normal mode)
            vim.keymap.set('n', '<leader>/', api.toggle.linewise.current, { desc = 'Toggle comment line' })

            -- Toggle comment (Visual mode)
            vim.keymap.set('x', '<leader>/', function()
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'nx', false)
                api.toggle.linewise(vim.fn.visualmode())
            end, { desc = 'Toggle comment selection' })
        end,
    },


    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        opts = {},
        keys = {
            -- Di chuyển giữa các todo comment
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },

            -- Trouble integration
            { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Toggle Todo (Trouble)" },
            { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Filter Todo/Fix/Fixme (Trouble)" },

            -- FZF-lua integration (thay vì Telescope)
            {
                "<leader>st",
                function()
                    require("fzf-lua").grep({ search = "TODO", no_esc = true })
                end,
                desc = "Search TODOs (fzf-lua)"
            },
            {
                "<leader>sT",
                function()
                    require("fzf-lua").grep({ search = "TODO|FIX|FIXME", no_esc = true })
                end,
                desc = "Search TODO/FIX/FIXME (fzf-lua)"
            },
        },
    },



    {
        "folke/flash.nvim",
        vscode = true,
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },


}
