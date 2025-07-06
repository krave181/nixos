{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    helix.url = "github:helix-editor/helix/master";
    steamtinkerlaunch = {
      url = "github:sonic2kk/steamtinkerlaunch/master";
      flake = false;
    };
    heroic = {
      url = "github:Heroic-Games-Launcher/HeroicGamesLauncher/main";
      flake = false;
    };
    lutris = {
      url = "github:lutris/lutris/master";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/desktop/configuration.nix
      ];
    };
  };
}