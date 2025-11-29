{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.secure-boot = {
        enable = mkEnableOption "secure boot through Lanzaboote";
      };
    };

  config =
    let
      cfg = config.planet.secure-boot;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        sbctl
      ];

      boot = {
        # Lanzaboote currently replaces the systemd-boot module,
        # so force set to false.
        loader.systemd-boot.enable = lib.mkForce false;
        lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
        };
      };

      planet.persistence = {
        directories = [
          "/var/lib/sbctl"
        ];
      };
    };
}
