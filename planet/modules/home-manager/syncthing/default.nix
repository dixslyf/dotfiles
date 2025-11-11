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
      planet.syncthing = {
        enable = mkEnableOption "planet syncthing";
      };
    };

  config =
    let
      cfg = config.planet.syncthing;
      inherit (lib) mkIf;

      allDevices = [
        "Beagle"
        "Shiba"
      ];

      defaultVersioning = {
        type = "simple";
        params.keep = "5";
      };
    in
    mkIf cfg.enable {
      # Make sure Syncthing is only started after keys are ready.
      systemd.user.services.syncthing.Unit.After = [ "sops-nix.service" ];

      services.syncthing = {
        enable = true;
        settings = {
          options = {
            urAccepted = -1; # Don't submit anonymous usage data.
          };
          devices = {
            Beagle = {
              id = "RZYREEI-WT3SY5W-GNHETW6-BB3JTZQ-EY7D7IT-ITNEMN6-JINDPVZ-BLI2EAC";
            };
            Shiba = {
              id = "6QEFL6Z-5SJYJQZ-ZB6YGUC-HI5MVGX-U5BVQIS-3ECQV45-R4T3ZZR-P7GWIAA";
            };
          };
          folders = {
            "~/Documents/Sync/Books" = {
              id = "cbksr-cj8z3";
              label = "Books";
              devices = allDevices;
              versioning = defaultVersioning;
            };
            "~/Documents/Sync/KeePass" = {
              id = "rquxl-fukaq";
              label = "KeePass";
              devices = allDevices;
              versioning = defaultVersioning;
            };
            "~/Documents/Sync/Logseq" = {
              id = "wwkvp-hcalu";
              label = "Logseq";
              devices = allDevices;
              versioning = defaultVersioning;
            };
            "~/Documents/Sync/Rclone" = {
              id = "eslt9-mhmot";
              label = "Rclone";
              devices = allDevices;
              versioning = defaultVersioning;
            };
          };
        };
      };
    };
}
