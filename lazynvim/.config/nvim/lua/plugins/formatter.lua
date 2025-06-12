-- return {
--   -- Autoformat on save
--   {
--     "neovim/nvim-lspconfig",
--     opts = {
--       servers = {
--         ts_ls = {
--           on_attach = function(client)
--             client.server_capabilities.documentFormattingProvider = false
--           end,
--         },
--         pyright = {
--           on_attach = function(client)
--             client.server_capabilities.documentFormattingProvider = false
--           end,
--         },
--         html = {},
--         cssls = {},
--         clangd = {},
--       },

--       setup = {
--         -- Format on save for supported LSPs
--         ["*"] = function(server, opts)
--           opts.on_attach = function(client, bufnr)
--             if client.supports_method("textDocument/formatting") then
--               vim.api.nvim_create_autocmd("BufWritePre", {
--                 buffer = bufnr,
--                 callback = function()
--                   vim.lsp.buf.format({ async = false })
--                 end,
--               })
--             end
--           end
--           require("lspconfig")[server].setup(opts)
--           return true
--         end,
--       },
--     },
--   },

--   -- Formatter setup with conform.nvim
--   {
--     "stevearc/conform.nvim",
--     opts = {
--       formatters_by_ft = {
--         javascript = { "prettier" },
--         typescript = { "prettier" },
--         html = { "prettier" },
--         css = { "prettier" },
--         json = { "prettier" },
--         yaml = { "prettier" },
--         python = { "black" },
--         c = { "clang_format" },
--         cpp = { "clang_format" },
--         lua = { "stylua" },
--         sh = { "shfmt" },
--       },
--     },
--   },
-- }
return{
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        python = { "black" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        lua = { "stylua" },
        sh = { "shfmt" },
      },
    },
  },
}