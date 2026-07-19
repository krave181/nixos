{ config, pkgs, ... }:

{
  # Basic info
  home.username = "steve";
  home.homeDirectory = "/home/steve";

  home.stateVersion = "25.11";

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
    #xfce4-whiskermenu-plugin
    #xfce4-panel
    #xfce4-i3-workspaces-plugin

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
 
