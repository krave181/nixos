{ config, pkgs, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
    };
    oci-containers.backend = "docker";
    libvirtd.enable = true;
  };

   # Flatpak + portals
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    config.common.default = "gtk";
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # AppImage support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    virt-manager
    edk2-uefi-shell
    quickemu
  ];
}
