-- return {
--     "mfussenegger/nvim-dap",
--     dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "leoluz/nvim-dap-go" },
--     config = function()
--         local dap, dapui = require("dap"), require("dapui")
--         require("dap-go").setup()
--         require("dapui").setup()

--         dap.listeners.before.attach.dapui_config = function()
--             dapui.open()
--         end
--         dap.listeners.before.launch.dapui_config = function()
--             dapui.open()
--         end
--         dap.listeners.before.event_terminated.dapui_config = function()
--             dapui.close()
--         end
--         dap.listeners.before.event_exited.dapui_config = function()
--             dapui.close()
--         end
--         vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
--         vim.keymap.set("n", "<Leader>dc", dap.continue, {})
--     end,
-- }

-- dont for get to install debugger here: https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- eg: go... brew install delve, then add go dependencies
-- lua/plugins/debug.lua
return {
    -- Core DAP
    -- {
    --     "mfussenegger/nvim-dap",
    --     dependencies = {
    --         "rcarriga/nvim-dap-ui",
    --         "leoluz/nvim-dap-go",
    --     },
    --     config = function()
    --         local dap = require("dap")
    --         local dapui = require("dapui")

    --         -- UI setup
    --         dapui.setup()

    --         -- Dap events
    --         dap.listeners.after.event_initialized["dapui_config"] = function()
    --             dapui.open()
    --         end
    --         dap.listeners.before.event_terminated["dapui_config"] = function()
    --             dapui.close()
    --         end
    --         dap.listeners.before.event_exited["dapui_config"] = function()
    --             dapui.close()
    --         end

    --         -- go setup
    --         require("dap-go").setup()
    --     end,
    -- },

    -- Optional keymaps (giống VSCode)
    -- {
    --   "nvim-telescope/telescope-dap.nvim",
    --   dependencies = { "nvim-telescope/telescope.nvim" },
    --   config = function()
    --     require("telescope").load_extension("dap")
    --   end,
    -- },
}
