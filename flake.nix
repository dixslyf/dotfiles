{
  description = "My NixOS configuration";

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cachix-deploy = {
      url = "github:cachix/cachix-deploy-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    impermanence.url = "github:nix-community/impermanence";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin-grub = {
      url = "github:catppuccin/grub";
      flake = false;
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pers-pkgs.url = "github:PlayerNameHere/nix-pers-pkgs";
  };

  outputs =
    inputs @ { self
    , flake-parts
    , nixpkgs
    , pers-pkgs
    , cachix-deploy
    , ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./devshell/flake-module.nix
      ];

      systems = [ "x86_64-linux" ];
      perSystem =
        { pkgs
        , ...
        }: {
          formatter = pkgs.nixpkgs-fmt;

          packages.cachix-deploy-spec =
            let
              cachix-deploy-lib = cachix-deploy.lib pkgs;
            in
            cachix-deploy-lib.spec {
              agents = {
                shiba-asus = self.nixosConfigurations.shiba-asus.config.system.build.toplevel;
              };
            };
        };

      flake = {
        nixosConfigurations = {
          shiba-asus = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              {
                nixpkgs.overlays = [
                  inputs.rust-overlay.overlays.default
                  inputs.neovim-nightly-overlay.overlay
                  inputs.nil.overlays.default
                  pers-pkgs.overlays.default
                ];
                nix.registry.nixpkgs.flake = nixpkgs;
              }
              ./hosts/shiba-asus
            ];
            specialArgs = { inherit inputs; };
          };
        };
      };
    };
}
