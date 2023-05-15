{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    formatter = pkgs.nixpkgs-fmt;

    devShells.default = inputs.devenv.lib.mkShell {
      inherit inputs pkgs;
      modules = [ ./default ];
    };
  };
}
