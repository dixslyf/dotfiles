local dap = require("dap")
local wk = require("which-key")

vim.keymap.set("n", "<leader>Db", dap.toggle_breakpoint, { silent = true, desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>Dc", dap.continue, { silent = true, desc = "Continue" })
vim.keymap.set("n", "<leader>Ds", dap.step_over, { silent = true, desc = "Step over" })
vim.keymap.set("n", "<leader>DS", dap.step_over, { silent = true, desc = "Step into" })
vim.keymap.set("n", "<leader>Dr", dap.repl.open, { silent = true, desc = "Open REPL" })

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
