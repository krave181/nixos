{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "steve";
  home.homeDirectory = "/home/steve";
  programs.stateVersion = "25.11";

 
  home.packages = with pkgs; [
    # stable packages
    programs.git = { enable = true; ... };
    pkgs.fortune


    #unstable packages
    unstable.heroic 
  ];


# Program configurations

programs = {
  git = {
    enable = true;
  };

  bash = {
    enable = true;
    shellAliases = {
    ll = "ls -l";
    };
  };

  home-manager = {
    enable = true
  };
};
 
# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.
  home.file = {
    ".screenrc".source = ./dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "vim";
  };
};
 
