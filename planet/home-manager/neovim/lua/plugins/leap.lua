local M = {}

function M.setup()
   vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
   vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
end

return M
