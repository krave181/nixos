# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #Enable nfs services, so I can mount nfs manually 
  boot.supportedFilesystems = [ "nfs" ];
  services.rpcbind.enable = true;

  # Blacklist the driver for the SDR
  boot.blacklistedKernelModules =
    [ #list of items that need to be blacklisted
      "dvb_usb_rtl28xxu"
    ];

  networking = { 
     firewall = {
        allowedTCPPorts = [];
        allowedUDPPorts = [];
        enable = false;
     };
      hostName = "desktop"; # Define your hostname.
      networkmanager.enable = true;
      wireless.enable = false;
  };

  hardware = {
   bluetooth.enable = true;
   #Enable rtl-sdr
   rtl-sdr.enable = true;
   pulseaudio.enable = false;
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
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

  services = {
   xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
   enable = true;
   displayManager = {
     defaultSession = "xfce+i3";
     lightdm.enable = true;
   };
   windowManager.i3 = {
     enable = true;
     extraPackages = with pkgs; [
       i3status
     ];
   };
   desktopManager = {
     xterm.enable = false;
     xfce = {
       enable = true;
       noDesktop = true;
       enableXfwm = false;
     };
   };
   };
  };

   # Enable common container config files in /etc/containers
   virtualisation = {
     docker = {
       enable = true;
     };  
     # dockerCompat = true;
     # Required for containers under podman-compose to be able to talk to each other.
     #defaultNetwork.settings.dns_enabled = true;
     oci-containers.backend = "docker";
   };


#########  Static above #########

 # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [

    # Flakes clones its dependencies through the git command,
    # so git must be installed first
    git
    vim-full
    wget
    curl
    gparted
    htop
    neofetch
    xfce.xfce4-i3-workspaces-plugin
    i3blocks
    gdu
    xfsprogs
    cifs-utils
    nfs-utils
    mdadm
    hplip
    python3
    pavucontrol
    firefox
    libsForQt5.falkon
    unzip
    dmenu
    networkmanagerapplet
    nitrogen
    pasystray
    rofi
    redshift
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-panel
    xfce.thunar-archive-plugin
    p7zip
    xz
    unrar
    unzip
    zulu17  #Java
    xorg.xkill
    remmina
    appimage-run
    xfce.thunar-volman  
#    home-manager 
    dex #autostarts applications from .desktop files
    tartube-yt-dlp
    usbutils
    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
#    xdg-desktop-portal-gtk # for flatpak
#    flatpak
    podman
    shadow
    distrobox
    tilda

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    font-manager

    #Gaming stuff
    mangohud

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # External packages
    inputs.helix.packages."${pkgs.system}".helix

  ];
  # Set the default editor to vim
  environment.variables.EDITOR = "vim-full";


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.steve = {
    isNormalUser = true;
    description = "steve";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "docker" "gamemode" ];
   # subGidRanges = [
   #   {
   #       count = 65536;
   #       startGid = 1000;
   #     }
   #   ];  
   # subUidRanges = [
   #   {
   #       count = 65536;
   #       startGid = 1000;
   #      }
   #    ];
    packages = with pkgs; [

    ###  Compiled applications from flake.nix  ####  
    heroic
    steamtinkerlaunch
    lutris
    ####

      # Chat stuff
      discord
      hexchat


#       python312Packages.pip #EDCD

      # Game tools
      wine
      winetricks
      protontricks
      protonup-qt
      protonup
##      yad
      gamescope

      # System tools
      libsForQt5.filelight
      ksnip
      solaar
      i3ipc-glib
      thunderbird
      wireshark
      sylpheed
      virt-manager-qt
      edk2-uefi-shell
      quickemu
      ntfs3g

      # browsers
      #chromium
      opera
      brave

      # Editors
      vscodium

     # General Software
      calibre
      picom-next #compton replacement
      gpodder
      rtl-sdr
      gqrx
      libsForQt5.k3b
      dvdplusrwtools
      freetube
      bottles
    ];
  };

  # Game runners
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/$USER/.steam/root/compatibilitytools.d";
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #Adds media type support for appimages
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Tailscale
  services.tailscale.enable = true;

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

 # # Load NVIDIA driver for Xorg and Wayland
 # services.xserver.videoDrivers = ["nvidia"];

   # Enable OpenGL
    hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

#  hardware.nvidia = {
#    enable = true;
#  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.modesetting.enable = true;

    ## Modesetting is required.
    #modesetting.enable = true;
    # Nvidia power management (experimental, may affect sleep/suspend).
    #powerManagement.enable = false;
    #open = false;
    ## Enable the Nvidia settings menu,
    ## accessible via `nvidia-settings`.
    #nvidiaSettings = true;

  #};


  #Mount drives
  fileSystems."/home" = { 
      device = "/dev/disk/by-uuid/d38ef527-feb9-49bb-b1db-d08f5a9be685";
      fsType = "xfs";
      options = [ "nofail" ];
    };

    fileSystems."/mnt/spare" = { 
      device = "/dev/disk/by-uuid/f6adc0ca-0d49-43a0-a184-408078c2f9d3";
      fsType = "xfs";
    };

  fileSystems."/home/steve/Downloads" = {
      device = "/mnt/spare/Downloads";
      options = [ "bind" ];
   };

   fileSystems."/mnt/steam_ssd" = { 
      device = "/dev/disk/by-uuid/7e1eed71-9606-4baf-8945-c59ba23ea621";
      fsType = "xfs";
    };

    fileSystems."/mnt/steam" = { 
      device = "/dev/disk/by-uuid/ccec1bca-9285-4389-a083-e068ba0d906b";
      fsType = "xfs";
    };

    fileSystems."/mnt/vg_home" = { 
      device = "/dev/disk/by-uuid/ecab7228-1ced-41ed-8290-321fb0075d7d";
      fsType = "xfs";
      options = [ "nofail" ];
    };

# NFS share mounts
  fileSystems."/mnt/share" = 
     { device = "192.168.10.50:/volume2/share";
       fsType = "nfs";
       options = [ "nofail" ];
     };

  fileSystems."/mnt/plex" = 
     { device = "192.168.10.50:/volumeUSB1/usbshare";
       fsType = "nfs";
       options = [ "nofail" ];
     };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
