{ config
, lib
, pkgs
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.file-roller = {
        enable = mkEnableOption "planet file-roller";
        defaultApplication = {
          enable = mkEnableOption "MIME default application configuration";
          mimeTypes = mkOption {
            type = types.listOf types.str;
            default = [
              "application/bzip2"
              "application/gzip"
              "application/vnd.android.package-archive"
              "application/vnd.ms-cab-compressed"
              "application/vnd.debian.binary-package"
              "application/x-7z-compressed"
              "application/x-7z-compressed-tar"
              "application/x-ace"
              "application/x-alz"
              "application/x-apple-diskimage"
              "application/x-ar"
              "application/x-archive"
              "application/x-arj"
              "application/x-brotli"
              "application/x-bzip-brotli-tar"
              "application/x-bzip"
              "application/x-bzip-compressed-tar"
              "application/x-bzip1"
              "application/x-bzip1-compressed-tar"
              "application/x-cabinet"
              "application/x-cd-image"
              "application/x-compress"
              "application/x-compressed-tar"
              "application/x-cpio"
              "application/x-chrome-extension"
              "application/x-deb"
              "application/x-ear"
              "application/x-ms-dos-executable"
              "application/x-gtar"
              "application/x-gzip"
              "application/x-gzpostscript"
              "application/x-java-archive"
              "application/x-lha"
              "application/x-lhz"
              "application/x-lrzip"
              "application/x-lrzip-compressed-tar"
              "application/x-lz4"
              "application/x-lzip"
              "application/x-lzip-compressed-tar"
              "application/x-lzma"
              "application/x-lzma-compressed-tar"
              "application/x-lzop"
              "application/x-lz4-compressed-tar"
              "application/x-ms-wim"
              "application/x-rar"
              "application/x-rar-compressed"
              "application/x-rpm"
              "application/x-source-rpm"
              "application/x-rzip"
              "application/x-rzip-compressed-tar"
              "application/x-tar"
              "application/x-tarz"
              "application/x-tzo"
              "application/x-stuffit"
              "application/x-war"
              "application/x-xar"
              "application/x-xz"
              "application/x-xz-compressed-tar"
              "application/x-zip"
              "application/x-zip-compressed"
              "application/x-zstd-compressed-tar"
              "application/x-zoo"
              "application/zip"
              "application/zstd"
            ];
            description = ''
              MIME types to be the default application for.
            '';
          };
        };
      };
    };

  config =
    let
      cfg = config.planet.file-roller;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [ file-roller ];
      xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication.enable (
        lib.genAttrs cfg.defaultApplication.mimeTypes (_: "org.gnome.FileRoller.desktop")
      );
    };
}
