{
  config,
  pkgs,
  lib,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.nix = {
        enable = mkEnableOption "planet nix";
      };
    };

  config =
    let
      cfg = config.planet.nix;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      nix = {
        # Garbage collection
        gc = {
          automatic = true;
          options = "--delete-older-than 14d";
        }
        # GC timing has different options on darwin and linux.
        // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
          persistent = true;
          dates = "Wed 21:00";
        }
        // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
          interval = [
            {
              # Wednesday 12:00
              Hour = 12;
              Minute = 0;
              Weekday = 1;
            }
          ];
        };

        optimise = {
          automatic = true;
        }
        // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
          persistent = true;
          dates = [
            "Thu 21:00"
          ];
        }
        // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
          interval = [
            {
              # Thursday 12:00
              Hour = 12;
              Minute = 0;
              Weekday = 4;
            }
          ];
        };

        # Other nix settings
        settings = {
          keep-outputs = true;
          keep-derivations = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          substituters = [
            "https://dixslyf.cachix.org"
            "https://nix-gaming.cachix.org"
            "https://hyprland.cachix.org"
            "https://nix-community.cachix.org"
          ];
          trusted-public-keys = [
            "dixslyf.cachix.org-1:6x8b4tr/2LBObGAlAGS1fbW3B3nK1FvL0CH9uRxjmI4="
            "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          ];
        };
      };
    };
}
