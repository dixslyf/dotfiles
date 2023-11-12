local lsp_common = require("plugins.lspconfig.common")

local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")
local wk = require("which-key")

local root_markers = { "gradlew", ".git", "mvnw", "pom.xml" }
local root_dir = jdtls_setup.find_root(root_markers)

-- Use `~/.cache/nvim/jdtls` appended with `root_dir` for the data directory.
-- If no `root_dir` was found, then concatenate with the current directory.
-- `:h` removes the trailing `/`. See `:help filename-modifiers`.
local data_dir_suffix = root_dir or vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h")
local data_dir = vim.fn.stdpath("cache") .. "/jdtls" .. data_dir_suffix

local bundles
do
   local b = { vim.fn.glob(Globals.java_debug_server_dir .. "/com.microsoft.java.debug.plugin-*.jar", true) }

   -- Add `vscode-java-test` `.jar` files to `bundles`.
   vim.list_extend(b, vim.split(vim.fn.glob(Globals.java_test_server_dir .. "/*.jar", true), "\n"))

   bundles = b
end

jdtls.start_or_attach({
   cmd = {
      Globals.jdt_ls,
      "-data",
      data_dir,
   },
   init_options = { bundles = bundles },
   root_dir = root_dir,
   capabilities = lsp_common.capabilities(),
   settings = {
      java = {
         format = false,
      },
   },
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

      vim.keymap.set("n", "<leader>ltc", jdtls.test_class, { buffer = bufnr, desc = "Class" })

      vim.keymap.set("n", "<leader>ltm", jdtls.test_nearest_method, { buffer = bufnr, desc = "Nearest method" })
   end,
})
