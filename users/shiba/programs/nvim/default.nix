{pkgs, ...}: {
  xdg.configFile."nvim/lua".source = ./lua;
  xdg.configFile."nvim/config.lua".source = ./config.lua;
  programs.neovim = {
    enable = true;
    extraConfig = ''
      luafile ~/.config/nvim/config.lua
    '';
    plugins = with pkgs.pvtpkgs.vimPlugins; [
      catppuccin-nvim
      feline-nvim
      nvim-web-devicons
      nvim-lspconfig
      which-key-nvim
      hydra-nvim
      gitsigns-nvim
    ];
    extraPackages = with pkgs; [
      sumneko-lua-language-server
    ];
  };
}
