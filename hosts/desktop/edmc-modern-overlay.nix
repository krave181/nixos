{ pkgs, lib }:
pkgs.python312Packages.buildPythonPackage rec {
  pname = "edmc-modernoverlay";
  version = "0.9.1";
  pyproject = true;

  src = pkgs.fetchFromGitHub {
    owner = "SweetJonnySauce";
    repo = "EDMC-ModernOverlay";
    rev = "v0.9.1";
    hash = "sha256-...";
  };

  nativeBuildInputs = with pkgs.python312Packages; [
    setuptools
    wheel
  ];

  propagatedBuildInputs = with pkgs.python312Packages; [
    requests
    pyqt6
    pillow
    sqlalchemy
  ];
}