{pkgs, ...}: {
  xdg.configFile."nvim/lua".source = ./lua;
  xdg.configFile."nvim/config.lua".source = ./config.lua;
  programs.neovim = {
    enable = true;
    extraConfig = ''
      luafile ~/.config/nvim/config.lua
    '';
    plugins = with pkgs.pvtpkgs.vimPlugins; [
      plenary-nvim
      catppuccin-nvim
      feline-nvim
      nvim-web-devicons
      nvim-lspconfig
      null-ls-nvim
      neodev-nvim
      vim-nix
      which-key-nvim
      hydra-nvim
      gitsigns-nvim
    ];
    extraPackages = with pkgs; [
      rnix-lsp
      sumneko-lua-language-server
    ];
  };
}
