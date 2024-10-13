{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    formatter = pkgs.nixfmt-rfc-style;

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
