local lazypath = Globals.lazy_nvim_path
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
   -- Override directories for plugins loaded by LazyVim.
   spec = vim.list_extend(dofile(Globals.plugin_dirs_lua_path), {
      -- Add LazyVim and import its plugins.
      { "LazyVim/LazyVim", import = "lazyvim.plugins" },

      -- Import specs from the `plugins/` directory.
      { import = "plugins" },
   }),
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
