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
#    ./edxd.nix
#    ./home.nix
  ];

  # Basic system settings
  system.stateVersion = "25.11";
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
    
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable Flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  # nix.settings.download-buffer-size = 524288000;
  nix.settings.download-buffer-size = 734003200; # 700 MB

#  nixpkgs.config.permittedInsecurePackages = [ "electron-33.4.11" ];

}

