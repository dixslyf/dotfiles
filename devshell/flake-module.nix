{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    formatter = pkgs.nixpkgs-fmt;
    devShells.default = inputs.devenv.lib.mkShell {
      inherit inputs pkgs;
      modules = [
        {
          packages = with pkgs; [ sops npins nixpkgs-fmt stylua statix deadnix ];
          pre-commit = {
            hooks = {
              nixpkgs-fmt = {
                enable = true;
                excludes = [ "^pkgs/npins/" ];
              };
              statix.enable = true;
              stylua.enable = true;
              deadnix.enable = true;
            };

            settings.statix.ignore = [ "pkgs/npins/" ];
          };
        }
      ];
    };
  };
}
