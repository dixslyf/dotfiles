{pkgs, ...}: {
  imports = [./module.nix];
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
      hydra-nvim
      gitsigns-nvim
    ];
  };
}
