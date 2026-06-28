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

        # Local plugin package expression is imported from ./edmc-modern-overlay.nix
    # so no external flake input is needed for EDMCModernOverlay.
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    packages.x86_64-linux.edmc-modern-overlay =
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      in
      import ./hosts/desktop/edmc-modern-overlay.nix {
        inherit pkgs;
        lib = pkgs.lib;
      };

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs self; };
      modules = [
        ./hosts/desktop/configuration.nix
      ];
    };
  };
}
