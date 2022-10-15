require("gitsigns").setup {
    numhl = true,
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        local function next_hunk()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end
        
        local function prev_hunk()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end

        map('n', ']c', next_hunk, {expr = true, desc = "Next Hunk"})
        map('n', '<leader>gj', next_hunk, {expr = true, desc = "Next hunk"})
        map('n', '[c', prev_hunk, {expr = true, desc = "Previous hunk"})
        map('n', '<leader>gk', prev_hunk, {expr=true, desc = "Previous hunk"})

        -- Actions
        map({'n', 'v'}, '<leader>gs', ':Gitsigns stage_hunk<CR>', {desc = "Stage hunk"})
        map({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>', {desc = "Reset hunk"})
        map('n', '<leader>gS', gs.stage_buffer, {desc = "Stage buffer"})
        map('n', '<leader>gu', gs.undo_stage_hunk, {desc = "Stage hunk"})
        map('n', '<leader>gR', gs.reset_buffer, {desc = "Reset buffer"})
        map('n', '<leader>gp', gs.preview_hunk, {desc = "Preview hunk"})
        map('n', '<leader>gb', function() gs.blame_line{full = true} end, {desc = "Blame line (full)"})
        map('n', '<leader>gtb', gs.toggle_current_line_blame, {desc = "Toggle current line blame"})
        map('n', '<leader>gd', gs.diffthis, {desc = "Diff"})
        map('n', '<leader>gD', function() gs.diffthis('~') end, {desc = "Diff ~"})
        map('n', '<leader>gtd', gs.toggle_deleted, {desc = "Toggle deleted"})

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {desc = "hunk"})

        -- Register prefixes
        local wk = require("which-key")
        wk.register {
            ["<leader>g"] = {
                name = "Git",
                t = "Toggle"
            }
        }
    end
}
