-- return {
--     {
--         "L3MON4D3/LuaSnip",
--         dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
--     },

--     {
--         "hrsh7th/cmp-nvim-lsp",
--         "hrsh7th/cmp-buffer",
--         "hrsh7th/cmp-path",
--         "hrsh7th/cmp-cmdline",
--     },

--     {
--         "hrsh7th/nvim-cmp",
--         config = function()
--             local cmp = require("cmp")
--             require("luasnip.loaders.from_vscode").lazy_load()

--             cmp.setup({
--                 snippet = {
--                     expand = function(args)
--                         require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
--                     end,
--                 },
--                 window = {
--                     completion = cmp.config.window.bordered(),
--                     documentation = cmp.config.window.bordered(),
--                 },
--                 mapping = cmp.mapping.preset.insert({
--                     ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--                     ["<C-f>"] = cmp.mapping.scroll_docs(4),
--                     ["<C-Space>"] = cmp.mapping.complete(),
--                     ["<C-e>"] = cmp.mapping.abort(),
--                     ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--                     ["<C-k>"] = cmp.mapping.select_prev_item(),
--                     ["<C-j>"] = cmp.mapping.select_next_item(),
--                 }),
--                 sources = cmp.config.sources({
--                     { name = "nvim_lsp" },
--                     { name = "luasnip" },
--                     { name = "zls" },
--                     { name = "buffer" },
--                     { name = "path" },
--                     -- { name = "pylsp" },
--                     { name = "pyright" },
--                     { name = "gci" },
--                     -- { name = "ts_ls" },
--                     { name = "vtsls" },
--                     { name = "gopls" },
--                     -- { name = "nix" },
--                     { name = "buf_ls" },
--                     { name = "render-markdown" },
--                 }),
--             })
--         end,
--     },

-- }
return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
        },
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snip]",
                            buffer = "[Buf]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
            })

            -- Setup for cmdline (optional)
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end,
    },
}
