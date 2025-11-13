{ pkgs, ... }:

{
  packages = with pkgs; [
    sops
    npins
    nixfmt-rfc-style
    stylua
    statix
    deadnix
    age
  ];

  git-hooks = {
    hooks = {
      nixfmt-rfc-style = {
        enable = true;
        excludes = [
          "^planet/pkgs/npins/"
          "^planet/pkgs/vim-plugins/npins/"
        ];
      };
      statix = {
        enable = true;
        settings = {
          ignore = [
            "planet/pkgs/npins/"
            "planet/pkgs/vim-plugins/npins/"
          ];
        };
      };
      stylua.enable = true;
      deadnix.enable = true;
    };
  };

  containers = pkgs.lib.mkForce { };
}
