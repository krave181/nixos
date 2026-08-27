{ config, pkgs, inputs, ... }:

let
  hytale-launcher-wrapped = pkgs.writeShellScriptBin "hytale-launcher" ''
    export GDK_BACKEND=x11
    export WEBKIT_DISABLE_DMABUF_RENDERER=1
    exec ${inputs.hytale-launcher.packages.${pkgs.system}.default}/bin/hytale-launcher "$@"
  '';
in
  
 {
  # ====================
  # User Account (System Level)
  # ====================
  users.users.steve = {
    isNormalUser = true;
    description = "steve";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "docker" "gamemode" "cdrom" "audio" "video" ];
    shell = pkgs.bash;                
  };

  security.sudo.extraRules = [{
    users = [ "steve" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];

# ====================
  # System-wide packages (only things that truly need to be system-level)
  # ====================
  environment.systemPackages = with pkgs; [
    # Core tools
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
    curl
    # For EDCM Modern Overlay
    unstable.xdg-utils
    unstable.wmctrl
    unstable.python3
    unstable.python3Packages.pip
    unstable.libxcb
    unstable.xcb-util-cursor
    unstable.libxkbcommon
    ####
    rsync
    tilix
    
    # Gaming / Hardware
    gamescope
    mangohud
    xdotool
    xwininfo

    # Virtualization / Containers
    unstable.podman
    distrobox
    
    # Misc system utilities
    onlyoffice-desktopeditors
    pavucontrol
    networkmanagerapplet
    appimage-run
    nix-ld
  ];
  
 # Environment variables (system-wide)
  environment.variables.EDITOR = "vim-full";

  environment.pathsToLink = [ "/libexec" ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/stevenixos/.steam/root/compatibilitytools.d";
  };
}
