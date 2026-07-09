{ config, pkgs, inputs, ... }:

let
  hytale-launcher-wrapped = pkgs.writeShellScriptBin "hytale-launcher" ''
    export GDK_BACKEND=x11
    export WEBKIT_DISABLE_DMABUF_RENDERER=1
    exec ${inputs.hytale-launcher.packages.${pkgs.system}.default}/bin/hytale-launcher "$@"
  '';
in
  
  {
  # Define user
  users.users.steve = {
    isNormalUser = true;
    description = "steve";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "docker" "gamemode" "cdrom" ];
    packages = with pkgs; [
      heroic
      steamtinkerlaunch
      hytale-launcher-wrapped
      discord
      hexchat
      gamescope
      ksnip
      i3ipc-glib
      thunderbird
      brave
      vscodium
      calibre
      picom
      gpodder
      #SDR 
      rtl-sdr
      gqrx

      kdePackages.k3b
      cdrdao
      cdrkit
      kdePackages.okular 
     ##  XFCE
      xfce4-whiskermenu-plugin
      xfce4-panel
      thunar-archive-plugin
      thunar-volman
      xfce4-i3-workspaces-plugin
      xarchiver
      kxstitch
      wpsoffice
      soundconverter
      edmarketconnector
      #edmc module requirements
      python314Packages.sqlalchemy
    ];
  };

  security.sudo.extraRules = [{
    users = ["steve"];
    commands = [{ command = "ALL";
      options = ["NOPASSWD"];
    }];
  }];

  # System packages
  environment.systemPackages = with pkgs; [
    git
    vim-full
    wget
    curl
    gparted
    htop
    hyfetch 
    i3blocks
    i3status
    xfsprogs
    cifs-utils
    nfs-utils
    mdadm
    yad
    hplip
    python3
    pavucontrol
    firefox
    kdePackages.falkon
    unzip
    dmenu
    networkmanagerapplet
    nitrogen
    pasystray
    rofi
    redshift
    p7zip
    xz
    unrar
    zulu17
    xkill
    remmina
    appimage-run
    tartube-yt-dlp
    usbutils
    hugo
    glow
    btop
    iotop
    iftop
    strace
    ltrace
    lsof
    sysstat
    lm_sensors
    ethtool
    pciutils
    podman
    shadow
    distrobox
    tilda
    cowsay
    file
    which
 #   peazip
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    font-manager
    mangohud
    mtr
    iperf3
    dnsutils
    ldns
    aria2
    socat
    nmap
    gdu
    ipcalc
    #steamtinkerlaunch dependencies
    xdotool
    xwininfo
    nix-ld
    asunder
    alacritty
    dvdplusrwtools
    nix-index
    devede
    xdg-utils  # For xdg-open and browser management
    spice
  ];
  


  # Environment variables
  environment.variables.EDITOR = "vim-full";
  environment.pathsToLink = [ "/libexec" ];
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/$USER/.steam/root/compatibilitytools.d";
  };
}
