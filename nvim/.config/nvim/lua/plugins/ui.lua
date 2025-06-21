return {


    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local lualine = require("lualine")
            local neogit = require("neogit")
            local diffview = require("diffview")

            local function toggle_neogit()
                local neogit_buffer_found = false
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
                    local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
                    if buftype == "nofile" and (filetype == "NeogitStatus" or filetype == "NeogitCommitMessage") then
                        neogit_buffer_found = true
                        vim.cmd("bd")
                        break
                    end
                end

                if not neogit_buffer_found then
                    neogit.open({ kind = "tab" })
                end
            end

            lualine.setup({
                options = {
                    theme = "vscode",
                    icons_enabled = true,
                    globalstatus = true,
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
                    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
                },
                sections = {
                    lualine_a = {
                        { "mode", icon = "" }, -- NORMAL/INSERT...
                    },
                    lualine_b = {
                        {
                            "branch",
                            icon = "",
                            on_click = function()
                                toggle_neogit()
                            end,
                        },
                        {
                            "diff",
                            symbols = {
                                added = " ",
                                modified = " ",
                                removed = " ",
                            },
                        },
                        {
                            "diagnostics",
                            symbols = {
                                error = " ",
                                warn = " ",
                                info = " ",
                                hint = "󰌵 ",
                            },
                        },

                    },
                    lualine_c = {
                        {
                            "filename",
                            path = 1, -- relative path
                            symbols = {
                                modified = " ●", -- file modified
                                readonly = " ", -- file readonly
                                unnamed = "[No Name]",
                            },
                        },
                    },
                    lualine_x = {
                        "encoding",
                        "fileformat",
                        "filetype",
                    },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {
                        {
                            "filename",
                            path = 1,
                        },
                    },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                extensions = {
                    "neo-tree",
                    "fugitive",
                    "toggleterm",
                    "lazy",
                    "quickfix",
                },
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

    {
        "kevinhwang91/nvim-ufo",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "kevinhwang91/promise-async" },
        config = function()
            -- Setup keymaps
            vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
            vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Fold less" })
            vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Fold more" })
            vim.keymap.set("n", "zp", require("ufo").peekFoldedLinesUnderCursor, { desc = "Peek fold" })

            -- Setup options
            vim.o.foldcolumn = "1"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            require("ufo").setup({
                preview = {
                    win_config = {
                        border = { "", "─", "", "", "", "─", "", "" },
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                        winblend = 0,
                    },
                    mappings = {
                        scrollU = "<C-u>",
                        scrollD = "<C-d>",
                    },
                },
                provider_selector = function(_, filetype, buftype)
                    local function fallback(bufnr, err, provider)
                        if type(err) == "string" and err:match("UfoFallbackException") then
                            return require("ufo").getFolds(bufnr, provider)
                        else
                            return require("promise").reject(err)
                        end
                    end

                    return (filetype == "" or buftype == "nofile") and "indent"
                        or function(bufnr)
                            return require("ufo")
                                .getFolds(bufnr, "lsp")
                                :catch(function(err) return fallback(bufnr, err, "treesitter") end)
                                :catch(function(err) return fallback(bufnr, err, "indent") end)
                        end
                end,
            })
        end,
    }

}
