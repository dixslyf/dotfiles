local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
   defaults = {
      mappings = {
         i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
         },
      },
   },
})

telescope.load_extension("fzf")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Man pages" })

local wk = require("which-key")
wk.register({ ["<leader>f"] = "Find" })
