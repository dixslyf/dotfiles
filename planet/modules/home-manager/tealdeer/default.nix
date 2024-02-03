{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.tealdeer = {
        enable = mkEnableOption "planet tealdeer";
      };
    };

  config =
    let
      cfg = config.planet.tealdeer;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.tealdeer = {
        enable = true;
        # Seems to encounter a network issue, but only when updating on activation.
        # According to https://github.com/nix-community/home-manager/pull/4968#issuecomment-1915718818,
        # this might be removed anyway since activation scripts shouldn't be performing network stuff.
        updateOnActivation = false;
        settings = {
          display = {
            use_pager = true;
            compact = true;
          };
          updates = {
            auto_update = true;
            auto_update_interval_hours = 168;
          };
        };
      };

      planet.persistence = {
        directories = [ ".cache/tealdeer" ];
      };
    };
}
