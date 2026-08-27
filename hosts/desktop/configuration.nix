{ config, pkgs, inputs, ... }:

{
  imports = [

    ./hardware-configuration.nix
    ./hardware.nix
    ./users.nix
    ./services.nix
    ./audio-recording.nix  
    ./filesystems.nix  
#    ./fonts.nix 
    ./networking.nix
    ./virtualization.nix
    ./user_packages.nix
#    ./tools.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_6_12;   # More stable for NVIDIA

  # Basic system settings
  time.timeZone = "America/New_York";
  system.stateVersion = "26.05";


  # Nix settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    download-buffer-size = 734003200;
  };

  nixpkgs.config.allowUnfree = true;

  nix.gc = {
  automatic = true;
  dates = "monthly";
  options = "--delete-older-than 30d";
  };
}
