{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    steamtinkerlaunch = {
      url = "github:sonic2kk/steamtinkerlaunch/master";
      flake = false;
    };
    
    heroic = {
      url = "github:Heroic-Games-Launcher/HeroicGamesLauncher/main";
      flake = false;
    };

    edxd = {
      url = "github:Kepas-Beleglorn/EDXD";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hytale-launcher.url = "github:JPyke3/hytale-launcher-nix";

        # Local plugin package expression is imported from ./edmc-modern-overlay.nix
    # so no external flake input is needed for EDMCModernOverlay.
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs: {
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        modernOverlay = pkgs.callPackage ./pkgs/edmc-modern-overlay.nix { };
      in  {
        packages = {
          default = modernOverlay;
          modernOverlay = modernOverlay;
        }
      });
  }
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs self; };
      modules = [
        ./hosts/desktop/configuration.nix
      ];
    };
  };
}
