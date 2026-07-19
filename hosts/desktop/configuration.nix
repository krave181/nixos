{ config, pkgs, inputs, ... }:



{
  imports = [
    ../../hardware-configuration.nix
    ./hardware.nix
    ./users.nix
    ./services.nix
    ./networking.nix
    ./virtualization.nix
    ./filesystems.nix
    ./audio-recording.nix
  ];

  # Basic system settings
  system.stateVersion = "25.11";
  time.timeZone = "America/New_York";
    
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable Flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nix.settings.download-buffer-size = 734003200; # 700 MB


  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.steve = import ./hosts/desktop/home.nix;
    backupFileExtension = "backup";
  };
} 
