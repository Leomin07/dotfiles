
return {

    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        dependencies = { "neovim/nvim-lspconfig" },
        opts = function(_, opts)
            table.insert(opts.sources, 1, { name = "nvim_lsp" })
        end,
    },

    -- ************************************************************
    -- VTSLS (TypeScript/JavaScript Language Server) Cấu hình
    -- ************************************************************
    {
        "yioneko/nvim-vtsls",
        lazy = false,
        ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
        -- No 'opts' initially, just to see if the plugin loads without a setup error
    },

    -- ************************************************************
    -- LuaSnip: Công cụ Snippet
    -- ************************************************************
    
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },

    {
        "hrsh7th/nvim-cmp",
        optional = true,
        dependencies = { "saadparwaiz1/cmp_luasnip" },
        opts = function(_, opts)
            opts.snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
            }
            table.insert(opts.sources, { name = "luasnip" })
        end,
        -- stylua: ignore
        keys = {
            { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
    },
}