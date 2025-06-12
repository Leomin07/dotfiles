return{
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("lualine").setup({
                options = {
                    theme = "OceanicNext",
                },
            })
        end,
    },

    {
        'akinsho/bufferline.nvim',
        event = "VeryLazy",
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        -- Các cài đặt tùy chọn khác của bufferline.nvim sẽ nằm ở đây
        config = function()
            require('bufferline').setup({
            options = {
                -- Ví dụ về một số tùy chọn phổ biến:
                numbers = "none", -- Hoặc "ordinal", "buffer_id"
                separator_style = "slant", -- Hoặc "padded_slant", "thick", "thin"
                always_show_bufferline = true,
                show_buffer_close_icons = false,
                show_close_icon = false,
                diagnostics = "nvim_lsp", -- Hiển thị diagnostics từ LSP
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local icon = level:match("error") and " " or " "
                return " " .. icon .. count
                end,
            }
            })
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},

        config = function()
            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }

            local hooks = require "ibl.hooks"
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            require("ibl").setup { indent = { highlight = highlight } }
            
        end
    },
    

    {
        "askfiy/visual_studio_code",
        priority = 100,
        config = function()
            vim.cmd([[colorscheme visual_studio_code]])
        end,
    },

    {
        'luochen1990/rainbow',
        event = { 'BufReadPre', 'BufNewFile' },
        init = function()
            vim.g.rainbow_active = 1
        end,
        config = function()
            vim.cmd('RainbowToggleOn')
        end,
    },

    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     main = "ibl",
    --     opts = function(_, opts)
    --         -- Other blankline configuration here
    --         return require("indent-rainbowline").make_opts(opts)
    --     end,
    --     dependencies = {
    --         "TheGLander/indent-rainbowline.nvim",
    --     },
    -- }

}