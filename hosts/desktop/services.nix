{ config, pkgs, ... }:
{
  # X server and desktop environment
  services.xserver = {
    enable = true;

    xkb = {
      layout = "us";
      variant = "";
    };

    # Desktop + Window Manager
    desktopManager.xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };

    windowManager.i3 = {
      enable = true;
      updateSessionEnvironment = true;
      extraPackages = with pkgs; [ i3status i3blocks ];
    };

    # LightDM Display Manager
    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "xfce+i3";
    
      #sessionCommands = ''
      #  export GBM_BACKEND=nvidia-drm
      #  export __GLX_VENDOR_LIBRARY_NAME=nvidia
      #  export LIBVA_DRIVER_NAME=nvidia
      #'';
  };

  # Sound with PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # Bluetooth
  services.blueman.enable = true;

  # File management and thumbnails
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # SSH
  services.openssh = {
    enable = true;
    settings.X11Forwarding = true;
  };

  # Tailscale VPN
  services.tailscale = {
    enable = true;
    package = pkgs.tailscale.overrideAttrs { doCheck = false; };
  };

  # NFS support
  services.rpcbind.enable = true;

  # Gaming
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  programs.gamemode.enable = true;

  # Firefox
  programs.firefox.enable = true;


  # System packages
  environment.systemPackages = with pkgs; [
    wineWow64Packages.stable
    winetricks
    steam-run
    protontricks
    protonup-ng
    input-leap
    dvdplusrwtools
    orca-slicer
    lutris-free
    ntfs3g
  ];

  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 30d";
  }; 

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;
}
