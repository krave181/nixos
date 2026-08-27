{ config, pkgs, lib, ... }:

{
  # Basic info
  home.username = "steve";
  home.homeDirectory = "/home/steve";

  home.stateVersion = "25.11";

  imports = [
   ./hosts/desktop/i3.nix
  ];

  #Services

  services.picom = {
  enable = true;
  vSync = true;            # helps with tearing on the 120Hz + rotated setup
  settings = {
    backend = "xrender";       # "xrender" is the fallback if glx misbehaves
    blur = {
      method = "gaussian";
      size = 10;
      deviation = 5.0;
    };
  };
  };

  # ====================
  # User Packages
  # ====================
  home.packages = with pkgs; [
    # Gaming
    unstable.heroic
    steamtinkerlaunch
    gamescope
    mangohud

    # Communication & Productivity
    discord
    hexchat
    thunderbird
    brave
    vscodium
    calibre
    gpodder

    # Utilities
    ksnip
    picom
    pcmanfm
    xarchiver
    nitrogen
    rofi
    dmenu
    pasystray
    redshift
    tilda
    cowsay
    fortune
    yad

    # Media / Graphics
    kdePackages.okular
    kdePackages.k3b
    soundconverter
    tartube-yt-dlp
    asunder
    devede

    # SDR
    rtl-sdr
    gqrx

    # XFCE / i3 plugins
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-panel
    xfce.xfce4-i3-workspaces-plugin

    # Development / Misc
    pkgs.python314Packages.sqlalchemy
    edmarketconnector
    hugo
    glow
    font-manager
  ];


# Program configurations

programs = {
  git = {
    enable = true;

    settings = {
      user.name = "steve";
      user.email = "edwardsm_99@yahoo.com";
    };
  };

  bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      nrs = "cd ~/nixos;sudo nixos-rebuild switch --flake .#desktop";
      bat = "bat -n -f --theme 1337 %1";
    };

    initExtra = ''
      export PS1='\[\e[38;5;112m\]\u\[\e[38;5;226m\]@\[\e[38;5;44m\]\H\[\e[0m\] in \[\e[38;5;191m\]\W\[\e[0m\] \[\e[38;5;155m\]>\[\e[0m\] '
    '';
  };

  alacritty = {  
    enable = true;
    settings = {
      key_bindings = [
        {
          key = "Backspace";
          chars = "\x7f";
        }
      ];
     window.opacity = 0.9;
     font.normal = {
       family = "JetBrains Mono";
       style = "Italic";
     };
     font.size = 16;
    };
  };

  home-manager.enable = true;
};



# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.
  home.file = {
    #".screenrc".source = ./dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
     EDITOR = "vim";
  };
}
 
