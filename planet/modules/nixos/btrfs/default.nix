{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.btrfs = {
        enable = mkEnableOption "planet btrfs";
        autoScrubFileSystems = mkOption {
          type = with types; listOf str;
          description = "
            A list of filesystems to auto-scrub.
          ";
        };
      };
    };

  config =
    let
      cfg = config.planet.btrfs;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.btrfs = {
        autoScrub = {
          enable = true;
          fileSystems = cfg.autoScrubFileSystems;
        };
      };

      planet.persistence = {
        directories = [ "/var/lib/btrfs" ];
      };
    };
}
