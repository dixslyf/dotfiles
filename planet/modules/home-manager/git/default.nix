{
  config,
  lib,
  ...
}:
{
  options =
    let
      inherit (lib)
        mkEnableOption
        mkOption
        types
        ;
    in
    {
      planet.git = {
        enable = mkEnableOption "planet git";
        profile = mkOption {
          type = types.enum [
            "personal"
            "work"
          ];
          description = ''
            The Git profile to use. Affects the user and signing configuration.
          '';
        };
      };
    };

  config =
    let
      cfg = config.planet.git;
      inherit (lib)
        mkIf
        mkMerge
        ;
    in
    mkIf cfg.enable (mkMerge [
      {
        programs.git = {
          enable = true;
          lfs.enable = true;
          settings = {
            user.name = "Dixon Sean Low Yan Feng";
            merge = {
              conflictStyle = "zdiff3";
              ff = false;
            };
            pull = {
              rebase = "merges";
            };
          };
          signing.signByDefault = true;
        };
      }
      {
        programs.git =
          if cfg.profile == "personal" then
            {
              settings = {
                user.email = "root@dixslyf.dev";
              };
              signing = {
                format = "opengpg";
                key = "A9F388161E9B90C7!";
              };
            }
          else
            # "work"
            {
              settings = {
                user.email = "dixon@subnero.com";
                gpg.ssh.allowedSignersFile = "${./allowed_signers}";
              };
              signing = {
                format = "ssh";
                key = "~/.ssh/gh_sign.pub";
              };
            };
      }
    ]);
}
