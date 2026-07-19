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
    
  #Nvidia compatable kernel
  boot.kernelPackages = pkgs.linuxPackages_6_12;

  # Enable Flakes and nix-command
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    download-buffer-size = 734003200; # 700 MB
  };

  nixpkgs.config.allowUnfree = true;
  
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.steve = import ./home.nix;
    backupFileExtension = "backup";
  };
} 
