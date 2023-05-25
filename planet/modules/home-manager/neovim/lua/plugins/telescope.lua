local M = {}

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local wk = require("which-key")

local function setup_mappings()
   vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Files" })
   vim.keymap.set("n", "<leader>fF", function()
      builtin.find_files({ hidden = true, no_ignore = true })
   end, { desc = "Files (all)" })
   vim.keymap.set("n", "<leader>fg", function()
      builtin.live_grep({ additional_args = { "--smart-case" } })
   end, { desc = "Grep" })
   vim.keymap.set("n", "<leader>fG", function()
      builtin.live_grep({
         additional_args = { "--smart-case", "--no-ignore", "--hidden" },
      })
   end, { desc = "Grep (all)" })
   vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
   vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
   vim.keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Man pages" })

   wk.register({ ["<leader>f"] = "Find" })
end

function M.setup()
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

   setup_mappings()
end

return M
