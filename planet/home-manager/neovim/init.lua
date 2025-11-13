Globals = {
   cppdbg_command = "@cppdbg_command@",
   jdt_ls = "@jdt_ls@",
   java_debug_server_dir = "@java_debug_server_dir@",
   java_test_server_dir = "@java_test_server_dir@",
   vscode_eslint_language_server_node_path = "@vscode_eslint_language_server_node_path@",
   vue_typescript_plugin_location = "@vue_typescript_plugin_location@",
}

require("options").setup()
require("plugins").setup()
