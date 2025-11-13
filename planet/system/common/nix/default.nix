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
          dates = "weekly";
          options = "--delete-older-than 14d";
        };

        # Other nix settings
        settings = {
          auto-optimise-store = true;
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
            "https://devenv.cachix.org"
          ];
          trusted-public-keys = [
            "dixslyf.cachix.org-1:6x8b4tr/2LBObGAlAGS1fbW3B3nK1FvL0CH9uRxjmI4="
            "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
          ];
        };
      };
    };
}
