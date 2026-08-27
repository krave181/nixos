{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    # === Core Tools ===
   git
   vim-full
   wget
   curl
   htop
   btop
   gparted
   nfs-utils
   cifs-utils
   usbutils
   pciutils
   lm_sensors
   nix-index
   xdg-utils
   file
   which
   tree
   gnupg
   gnused
   gnutar
   gawk
   zstd
   xz
   unzip
   p7zip
   unrar

   # === Monitoring & Diagnostics ===
   iotop
   iftop
   sysstat
   strace
   ltrace
   lsof
   mtr
   iperf3
   dnsutils
   ldns
   nmap
   ipcalc
   socat
   ethtool

   # === Desktop / WM Utilities ===
   i3blocks
   i3status
   dmenu
   rofi
   nitrogen
   pasystray
   pavucontrol
   redshift
   yad
   xkill
   tilda
   alacritty
   networkmanagerapplet

   # === Gaming / Hardware ===
    gamescope
   mangohud
   xdotool
   xwininfo

   # === Virtualization / Containers ===
   podman
   distrobox
   appimage-run
   nix-ld

   # === Browsers ===
   firefox
   kdePackages.falkon

   # === Media & Content ===
   asunder
   devede
   dvdplusrwtools

   # === Development & Languages ===
   python3
   zulu17          # Java 17
   hugo
   glow

   # === File Systems & Storage ===
   xfsprogs
   mdadm
   hplip

   # === Remote & Networking ===
   remmina
   aria2
   spice

   # === Office & Productivity ===
   onlyoffice-desktopeditors

   # === Misc Utilities ===
   hyfetch
   cowsay
   font-manager
   gdu
];
}