{ config, pkgs, ... }:

{
  # ======================
  # X Server + Desktop / WM
  # ======================
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

    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "xfce+i3";

    # Optional NVIDIA environment variables
    # sessionCommands = ''
    #   export GBM_BACKEND=nvidia-drm
    #   export __GLX_VENDOR_LIBRARY_NAME=nvidia
    #   export LIBVA_DRIVER_NAME=nvidia
    # '';
  };

  # ======================
  # Audio
  # ======================
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # ======================
  # Other Services
  # ======================
  services.printing.enable = true;
  services.blueman.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  services.openssh = {
    enable = true;
    settings.X11Forwarding = true;
  };

  services.tailscale = {
    enable = true;
    package = pkgs.tailscale.overrideAttrs { doCheck = false; };
  };

  services.rpcbind.enable = true;   # For NFS

  # ======================
  # Gaming
  # ======================
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  programs.gamemode.enable = true;

  # ======================
  # System-wide programs & tools
  # ======================
  environment.systemPackages = with pkgs; [
    wineWow64Packages.stable
    unstable.winetricks
    unstable.steam-run
    unstable.protontricks
    unstable.protonup-qt
    input-leap
    orca-slicer
    unstable.lutris
    ntfs3g
    dvdplusrwtools
  ];

  # ======================
  # Nix & Misc
  # ======================
  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 30d";
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib stdenv.cc.cc curl openssl libssh bzip2 libxml2
      xorg.libXcomposite xorg.libXtst xorg.libXrandr xorg.libXext
      xorg.libX11 xorg.libXfixes xorg.libxcb xorg.libXdamage
      xorg.libxshmfence xorg.libXxf86vm
      libGL libva pipewire glib gtk2
    ];
  };
}