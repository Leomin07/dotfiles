return {

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "vscode", -- hoặc "vscode", "tokyonight", v.v.
                    icons_enabled = true,
                    globalstatus = true,
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = { { "mode", icon = "" } },
                    lualine_b = {
                        { "branch", icon = "" },
                        { "diff", symbols = { added = " ", modified = " ", removed = " " } },
                        {
                            "diagnostics",
                            symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
                        },
                    },
                    lualine_c = {
                        {
                            "filename",
                            path = 1, -- relative path
                            symbols = {
                                modified = " ●", -- Text to show when the file is modified.
                                readonly = " ", -- Text to show when the file is non-modifiable or readonly.
                                unnamed = "[No Name]", -- Text to show for unnamed buffers.
                            },
                        },
                    },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                extensions = { "neo-tree", "fugitive", "toggleterm", "lazy", "quickfix" },
            })
        end,
    },


    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    numbers = "none",
                    close_command = "bdelete! %d",
                    right_mouse_command = "bdelete! %d",
                    left_mouse_command = "buffer %d",
                    middle_mouse_command = nil,

                    indicator = {
                        icon = "▎",
                        style = "icon",
                    },

                    buffer_close_icon = "󰅖", -- Biểu tượng đóng tab
                    modified_icon = "%#DiagnosticHint#●%*", -- Biểu tượng buffer chưa lưu
                    close_icon = "", -- Biểu tượng đóng toàn bộ
                    show_buffer_close_icons = true,
                    show_close_icon = true,

                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level)
                        local icon = level:match("error") and " " or " "
                        return " " .. icon .. count
                    end,

                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "󰙅 File Explorer",
                            highlight = "Directory",
                            text_align = "left",
                        },
                    },

                    separator_style = "slant",
                    always_show_bufferline = true,

                    -- Hiển thị khu vực custom nếu có buffer chưa lưu
                    custom_areas = {
                        left = function()
                            local result = {}
                            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                                if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "modified") then
                                    table.insert(result, { text = " ● Unsaved", fg = "#f7768e" })
                                    break
                                end
                            end
                            return result
                        end,
                    },
                },
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


    -- {
    --     "askfiy/visual_studio_code",
    --     priority = 100,
    --     config = function()
    --         vim.cmd([[colorscheme visual_studio_code]])
    --     end,
    -- },

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

    {
        "Mofiqul/vscode.nvim",
        priority = 1000,
        config = function()
            local vscode = require("vscode")
            vscode.setup({
                -- Bạn có thể chỉnh lại màu nếu muốn:
                italic_comments = true,
                disable_nvimtree_bg = true,
            })
            vscode.load("dark") -- hoặc "light"
        end,
    },

    

}
