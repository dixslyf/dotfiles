local dap = require("dap")
local dapui = require("dapui")
local wk = require("which-key")

-- Catppuccin
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define(
   "DapBreakpointCondition",
   { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
)
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

vim.keymap.set("n", "<leader>Db", dap.toggle_breakpoint, { silent = true, desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>Dc", dap.continue, { silent = true, desc = "Continue" })
vim.keymap.set("n", "<leader>DC", dap.reverse_continue, { silent = true, desc = "Reverse continue" })
vim.keymap.set("n", "<leader>Ds", dap.step_over, { silent = true, desc = "Step over" })
vim.keymap.set("n", "<leader>DS", dap.step_back, { silent = true, desc = "Step back" })
vim.keymap.set("n", "<leader>Df", dap.step_into, { silent = true, desc = "Step into" })
vim.keymap.set("n", "<leader>DF", dap.step_out, { silent = true, desc = "Step out" })
vim.keymap.set("n", "<leader>Dt", dap.terminate, { silent = true, desc = "Terminate" })
vim.keymap.set("n", "<leader>DD", dapui.toggle, { silent = true, desc = "Toggle UI" })

wk.register({ ["<leader>D"] = "Debug" })

dap.adapters.cppdbg = {
   id = "cppdbg",
   type = "executable",
   command = Globals.cppdbg_command,
}

dap.configurations.cpp = {
   {
      name = "Launch file",
      type = "cppdbg",
      request = "launch",
      program = function()
         return vim.fn.input({ prompt = "Path to executable: ", default = vim.fn.getcwd() .. "/", completion = "file" })
      end,
      cwd = "${workspaceFolder}",
      stopAtEntry = true,
      setupCommands = {
         {
            text = "-enable-pretty-printing",
            description = "enable pretty printing",
            ignoreFailures = false,
         },
      },
   },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dapui.setup()
