{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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

  outputs = { self, home-manager, nixpkgs, ... }@inputs: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
        ./hosts/desktop/configuration.nix
        # Add more modules here as needed
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.steve = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}