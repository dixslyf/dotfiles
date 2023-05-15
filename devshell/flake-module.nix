{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    formatter = pkgs.nixpkgs-fmt;

    devShells.default = inputs.devenv.lib.mkShell {
      inherit inputs pkgs;
      modules = [ ./default ];
    };

    devShells.ci = inputs.devenv.lib.mkShell {
      inherit inputs pkgs;
      modules = [ ./ci ];
    };
  };
}
