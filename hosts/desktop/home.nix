{pkgs, ...}: {
    home.username = "your.username";
    home.homeDirectory = "/home/steve";    
#    home.stateVersion = "24.11"; # Comment out for error with "latest" version
    programs.home-manager.enable = true;
}