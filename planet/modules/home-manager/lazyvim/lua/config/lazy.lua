local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   vim.api.nvim_err_writeln("Failed to find lazy.nvim!")
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
   spec = {
      -- Add LazyVim and import its plugins.
      { "LazyVim/LazyVim", import = "lazyvim.plugins" },

      -- Import specs from the `plugins/` directory.
      { import = "plugins" },
   },
   -- Since the plugins are managed through Nix,
   -- we don't need lazy.nvim to install or check them.
   install = { missing = false },
   checker = { enabled = false },
   performance = {
      rtp = {
         -- Neovim comes with some built-in RTP plugins.
         -- A list of these plugins can be found in Neovim's `runtime/plugin/` directory.
         -- This option lets you disable them.
         disabled_plugins = {
            "gzip",
            -- "matchit",
            -- "matchparen",
            -- "netrwPlugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
         },
      },
   },
})
