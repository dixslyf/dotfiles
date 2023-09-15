local lsp_common = require("plugins.lspconfig.common")

local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")
local wk = require("which-key")

local root_markers = { "gradlew", ".git", "mvnw" }
local root_dir = jdtls_setup.find_root(root_markers)

local data_dir
if root_dir == nil then
   -- If no `root_dir` was found, then use `~/.cache/nvim/jdtls` concatenated with the current working directory.
   -- `:h` removes the trailing `/`.
   data_dir = vim.fn.stdpath("cache") .. "/jdtls" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h")
else
   data_dir = root_dir .. "/.jdtls"
end

jdtls.start_or_attach({
   cmd = {
      Globals.jdt_ls,
      "-data",
      data_dir,
   },
   init_options = {
      bundles = {
         vim.fn.glob(Globals.java_debug_server_dir .. "/com.microsoft.java.debug.plugin-*.jar", true),
      },
   },
   root_dir = root_dir,
   capabilities = lsp_common.capabilities(),
   on_attach = function(client, bufnr)
      lsp_common.on_attach(client, bufnr)

      wk.register({
         ["<leader>l"] = {
            e = "Extract",
            t = "Test",
         },
      })

      vim.keymap.set("n", "<leader>lo", jdtls.organize_imports, { buffer = bufnr, desc = "Organize imports" })

      vim.keymap.set("n", "<leader>lev", jdtls.extract_variable, { buffer = bufnr, desc = "Variable" })

      vim.keymap.set(
         "x",
         "<leader>lev",
         "<ESC><CMD>lua require('jdtls').extract_variable(true)<CR>",
         { buffer = bufnr, desc = "Variable" }
      )

      vim.keymap.set("n", "<leader>lec", jdtls.extract_constant, { buffer = bufnr, desc = "Constant" })

      vim.keymap.set(
         "x",
         "<leader>lec",
         "<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>",
         { buffer = bufnr, desc = "Constant" }
      )

      vim.keymap.set(
         "x",
         "<leader>lem",
         "<ESC><CMD>lua require('jdtls').extract_method(true)<CR>",
         { buffer = bufnr, desc = "Method" }
      )
   end,
})
