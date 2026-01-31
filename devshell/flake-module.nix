_:

{
  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.nixfmt;

      devShells = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            sops
            npins
            nixfmt
            stylua
            statix
            deadnix
            age
          ];
        };
      };
    };
}
