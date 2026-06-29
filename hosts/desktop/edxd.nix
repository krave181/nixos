{ pkgs, ... }:

let
  edxdSrc = pkgs.fetchFromGitHub {
    owner = "Kepas-Beleglorn";
    repo = "EDXD";
    rev = "v0.8.0.0";
    hash = "sha256-acWdotWntJCDPUTStlOV96KPSkKseOUo50F057m+YEY=";
  };

  # Full argument list that default.nix expects
  edxdPkg = pkgs.callPackage "${edxdSrc}/default.nix" {
    inherit (pkgs) fetchFromGitHub buildPythonPackage setuptools wheel;
    inherit (pkgs) wayland libxkbcommon gtk3 glib nss nspr cairo pango harfbuzz zlib;
    inherit (pkgs.xorg) libX11 libXcursor libXrandr libXi libXrender libXext libXfixes libxcb xcbutil xcbutilimage xcbutilkeysyms xcbutilwm;
    inherit (pkgs.python3Packages) tomli watchdog wxpython filelock;
  };

in
{
  environment.systemPackages = [
    pkgs.edmarketconnector
    edxdPkg
  ];

  # Extra runtime libraries (X11 + wxPython)
  environment.systemPackages = with pkgs; [
    libXcursor
    libXrandr
    libXi
    libX11
    libXrender
    libXext
    libXfixes
    libxkbcommon
    gtk3
    glib
    zlib
    nss
    nspr
    cairo
    pango
    harfbuzz
  ];
}
