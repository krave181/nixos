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

    hytale-launcher.url = "github:JPyke3/hytale-launcher-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/desktop/configuration.nix
        # Add more modules here as needed
        ./home.nix
        home-manager.nixosModules.home-manager
      ];
    };
  };
}