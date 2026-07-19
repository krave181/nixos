{ config, pkgs, lib, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "nfs" ];

  # Hardware
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.rtl-sdr.enable = true;

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  # Disable PulseAudio (using PipeWire instead)
  services.pulseaudio.enable = false;

  # ======================
  # NVIDIA Configuration
  # ======================
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics.enable = true;

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.production;  # Good choice

    modesetting.enable = true;
    open = false;                    # Proprietary driver recommended for most users
    nvidiaSettings = true;           # Set to false if you don't want nvidia-settings GUI
    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };
}