{
  description = "Steven's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    steamtinkerlaunch = {
      url = "github:sonic2kk/steamtinkerlaunch/master";
      flake = false;
    };

    heroic = {
      url = "github:Heroic-Games-Launcher/HeroicGamesLauncher/main";
      flake = false;
    };

    hytale-launcher.url = "github:JPyke3/hytale-launcher-nix";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
        ./hosts/desktop/configuration.nix

        # Overlay for unstable packages
        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import inputs.nixpkgs-unstable {
                inherit (prev) system;
                config.allowUnfree = true;
              };
            })
          ];
        }

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };

            users.steve = import ./hosts/desktop/home.nix;
          };
        }
      ];
    };
  };
}