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
        sync = {
          books = mkEnableOption "Sync books";
          keepass = mkEnableOption "Sync KeePass";
          logseq = mkEnableOption "Sync Logseq";
          rclone = mkEnableOption "Sync Rclone";
        };
      };
    };

  config =
    let
      cfg = config.planet.syncthing;
      inherit (lib) mkIf;

      allDevices = [
        "Beagle"
        "Pomeranian"
        "Shiba"
        "Corgi"
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
            Pomeranian = {
              id = "HLXMCV4-M2K4CXO-M4MRNVF-XSKVWLN-RFTEQ5T-FD3IM4M-UTFUZD2-IAUVJA6";
            };
            Shiba = {
              id = "6QEFL6Z-5SJYJQZ-ZB6YGUC-HI5MVGX-U5BVQIS-3ECQV45-R4T3ZZR-P7GWIAA";
            };
            Corgi = {
              id = "CW3GYR6-6GU3PLB-MN6XZI7-FEXSI7H-FCNKI66-XUFKBLP-B2J46XX-GMUD2AL";
            };
          };
          folders = {
            "~/Documents/Sync/Books" = {
              id = "cbksr-cj8z3";
              enable = cfg.sync.books;
              label = "Books";
              devices = allDevices;
              versioning = defaultVersioning;
            };
            "~/Documents/Sync/KeePass" = {
              id = "rquxl-fukaq";
              enable = cfg.sync.keepass;
              label = "KeePass";
              devices = allDevices;
              versioning = defaultVersioning;
            };
            "~/Documents/Sync/Logseq" = {
              id = "wwkvp-hcalu";
              enable = cfg.sync.logseq;
              label = "Logseq";
              devices = allDevices;
              versioning = defaultVersioning;
            };
            "~/Documents/Sync/Rclone" = {
              id = "eslt9-mhmot";
              enable = cfg.sync.rclone;
              label = "Rclone";
              devices = allDevices;
              versioning = defaultVersioning;
            };
          };
        };
      };
    };
}
