require("gitsigns").setup {
    numhl = true,
    on_attach = function(bufnr)
        local hydra = require("hydra")
        local gs = require("gitsigns")
        local gs_conf = require("gitsigns.config").config
        local opts = { buffer = bufnr }
        local save = {}

        -- TODO: make multiline hint

        hydra {
            name = "Git",
            config = {
                buffer = bufnr,
                color = "pink",
                hint = {
                    type = "window",
                    border = "rounded"
                },
                invoke_on_body = true,
                on_enter = function()
                   vim.cmd("mkview")
                   vim.cmd("silent! %foldopen!")
                   vim.bo.modifiable = false

                   -- save values to restore later
                   save.signs = gs_conf.signcolumn
                   if not signs then gs.toggle_signs(true) end
                   save.numhl = gs_conf.numhl
                   if not numhl then gs.toggle_numhl(true) end
                   save.linehl = gs_conf.linehl
                   if not linehl then gs.toggle_linehl(true) end
                   save.deleted = gs_conf.show_deleted
                   if not deleted then gs.toggle_deleted(true) end
                end,
                on_exit = function()
                   local cursor_pos = vim.api.nvim_win_get_cursor(0)
                   vim.cmd("loadview")
                   vim.api.nvim_win_set_cursor(0, cursor_pos)
                   vim.cmd("normal zv")

                   -- restore values
                   if not save.signs then gs.toggle_signs(false) end
                   if not save.numhl then gs.toggle_numhl(false) end
                   if not save.linehl then gs.toggle_linehl(false) end
                   if not save.deleted then gs.toggle_deleted(false) end
                end,
            },
            mode = { "n", "x" },
            body = "<leader>g",
            heads = {
                { "J", gs.next_hunk, { desc = "next hunk" } },
                { "K", gs.prev_hunk, { desc = "prev hunk" } },
                {
                    "s",
                    function()
                        local mode = vim.fn.mode()
                        if mode == "v" or mode == "V" then
                            gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") }
                        else
                            gs.stage_hunk()
                        end
                    end,
                    { desc = "stage hunk" }
                },
                { "u", gs.undo_stage_hunk, { desc = "undo last stage" } },
                { "S", gs.stage_buffer, { desc = "stage buffer" } },
                {
                    "r",
                    function()
                        local mode = vim.fn.mode()
                        vim.bo.modifiable = true
                        if mode == "v" or mode == "V" then
                            gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") }
                        else
                            gs.reset_hunk()
                        end
                        vim.bo.modifiable = false
                    end,
                    { desc = "reset hunk" }
                },
                {
                    "R",
                    function()
                        vim.bo.modifiable = true
                        gs.reset_buffer()
                        vim.bo.modifiable = false
                    end,
                    { desc = "reset buffer" }
                },
                { "p", gs.preview_hunk, { desc = "preview hunk" } },
                { "x", gs.toggle_deleted, { desc = "toggle deleted" } },
                { "d", vim.schedule_wrap(function() gs.diffthis("") end), { desc = "diff", exit = true } },
                { "D", vim.schedule_wrap(function() gs.diffthis("~") end), { desc = "diff with ~", exit = true } },
                { "b", gs.blame_line, { desc = "blame" } },
                { "B", function() gs.blame_line { full = true } end, { desc = "blame show full" } },
                { "q", nil, { exit = true, desc = "exit" } },
            }
        }
    end
}
