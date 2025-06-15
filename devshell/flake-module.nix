{ inputs, ... }:
{
  imports = [
    inputs.devenv.flakeModule
  ];

  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.nixfmt-rfc-style;

      devenv.shells.default = {
        name = "dotfiles";
        imports = [
          ./default
        ];
      };

      devenv.shells.ci = {
        name = "ci";
        imports = [
          ./ci
        ];
      };
    };
}
