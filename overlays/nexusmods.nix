# overlays/nexusmods.nix
# This function is used to add custom packages or modifications to the standard nixpkgs set.
final: prev:

{
  nexusmods-app = final.callPackage (
    # Fetch the Nixpkgs source and append the path to the package definition
    (final.pkgs.fetchFromGitHub {
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "nixos-unstable";
      # The `sha256` must be explicitly provided for reproducibility
      sha256 = "sha256-hash-of-the-commit";
    }) + "/pkgs/by-name/ne/nexusmods-app"
  ) {};
}
