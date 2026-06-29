{ config, pkgs, ... }:

{
  fileSystems."/home" = {
    #device = "/dev/disk/by-uuid/5b22e4c5-91a7-431a-88d0-073a936df66a";
    device = "/dev/disk/by-uuid/e03487f4-e5d0-4004-896e-c94333458a7c";
    fsType = "xfs";
    options = [ "nofail" ];
  };

  fileSystems."/mnt/spare" = {
    device = "/dev/disk/by-uuid/f6adc0ca-0d49-43a0-a184-408078c2f9d3";
    fsType = "xfs";
    options = [ "nofail" ];
  };

  fileSystems."/home/steve/Downloads" = {
    device = "/mnt/spare/Downloads";
    fsType = "xfs";
    options = [ "bind" ];
  };

  fileSystems."/mnt/steam_ssd" = {
    device = "/dev/disk/by-uuid/7e1eed71-9606-4baf-8945-c59ba23ea621";
    fsType = "xfs";
    options = [ "nofail" ];
  };

#  fileSystems."/mnt/steam" = {
#    device = "/dev/disk/by-uuid/ccec1bca-9285-4389-a083-e068ba0d906b";
#    fsType = "xfs";
#    options = [ "nofail" ];
#  };

  fileSystems."/mnt/backup" = {
    device = "/dev/disk/by-uuid/7791311b-a92f-4383-b118-ad0a6b43a523";
    fsType = "xfs";
    options = [ "nofail" ];
  };

  fileSystems."/mnt/share" = {
    device = "192.168.10.50:/volume2/share";
    fsType = "nfs";
    options = [ "nofail" ];
  };

  fileSystems."/mnt/plex" = {
    device = "192.168.10.50:/volumeUSB1/usbshare";
    fsType = "nfs";
    options = [ "nofail" ];
  };
}
