return {
    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        -- opts will be merged with the parent spec
        opts = { use_diagnostic_signs = true },
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


}
