{ config
, lib
, pkgs
, ...
}: {
  options =
    let
      inherit (lib)
        mkOption
        mkEnableOption
        types;
    in
    {
      planet.xdg-terminal-exec = {
        enable = mkEnableOption "planet xdg-terminal-exec";
        command = mkOption {
          type = types.str;
          description = ''
            The command to execute to open the preferred terminal.
            This command will be written to a bash script via `pkgs.writeShellScriptBin`.
            Ensure that the command handles arguments passed to it using "$@" or similar.
          '';
        };
      };
    };

  config =
    let
      cfg = config.planet.xdg-terminal-exec;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      # Instead of configuring according to the overcomplicated spec,
      # the easier solution described in the comment below is used:
      # https://github.com/ublue-os/main/issues/211#issuecomment-1551600704
      home.packages = [
        (pkgs.writeShellScriptBin "xdg-terminal-exec" cfg.command)
      ];
    };
}
