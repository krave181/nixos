{ config, pkgs, lib, ... }:

{
  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
    wireless.enable = lib.mkForce false;
    firewall = {
      allowedTCPPorts = [];
      allowedUDPPorts = [];
      enable = false;
    };
  };
}

