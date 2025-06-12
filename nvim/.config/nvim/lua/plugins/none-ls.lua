-- return {
-- "nvimtools/none-ls.nvim",
-- config = function()
--     local null_ls = require("null-ls")
--     null_ls.setup({
--         sources = {
--             null_ls.builtins.formatting.stylua,
--             null_ls.builtins.formatting.prettier,
--             null_ls.builtins.diagnostics.erb_lint,
--             null_ls.builtins.diagnostics.rubocop,
--             null_ls.builtins.formatting.rubocop,
--             null_ls.builtins.formatting.stylua,
--         },
--     })

--     vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
-- end,
-- }
return {
    -- "nvimtools/none-ls.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    -- dependencies = {
    --     "nvim-lua/plenary.nvim",
    -- },
    -- config = function()
    --     local null_ls = require("null-ls")

    --     local formatting = null_ls.builtins.formatting
    --     local diagnostics = null_ls.builtins.diagnostics
    --     local code_actions = null_ls.builtins.code_actions

    --     null_ls.setup({
    --         sources = {
    --             -- Formatters
    --             -- formatting.prettier,         -- JS/TS/HTML/CSS/JSON/MD
    --             -- formatting.stylua,           -- Lua
    --             -- formatting.black,            -- Python
    --             formatting.shfmt,              -- Shell script
    --             -- formatting.taplo,           -- TOML
    --             -- formatting.gofmt,           -- Go

    --             -- Linters
    --             diagnostics.eslint_d,          -- JS/TS
    --             diagnostics.flake8,            -- Python
    --             diagnostics.markdownlint,      -- Markdown
    --             -- diagnostics.shellcheck,     -- Shell script

    --             -- Code actions (chỉ enable nếu tool hỗ trợ)
    --             -- code_actions.eslint,        -- Dùng cái này nếu bạn dùng eslint chuẩn
    --             -- code_actions.gitsigns,
    --         },
    --     })

    --     -- Optional: Auto format on save
    --     -- vim.api.nvim_create_autocmd("BufWritePre", {
    --     --     pattern = { "*.js", "*.ts", "*.lua", "*.py", "*.sh", "*.json", "*.md" },
    --     --     callback = function()
    --     --         vim.lsp.buf.format({ async = false })
    --     --     end,
    --     -- })
    -- end,
}
