{
  config,
  lib,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.udisks2 = {
        enable = mkEnableOption "planet udisks2";
      };
    };

  config =
    let
      cfg = config.planet.udisks2;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.udisks2 = {
        enable = true;
        settings = {
          "mount_options.conf" = {
            defaults = {
              defaults = "noatime";
            };
          };
        };
      };

      # ntfs-3g driver
      # Required by udisks to mount due to the "windows_names" mount option
      boot.supportedFilesystems = [ "ntfs" ];
    };
}
