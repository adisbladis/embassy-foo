{
  description = "A very basic flake";

  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, fenix }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {

    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = [
        pkgs.pkg-config
        pkgs.probe-rs
        (
          fenix.packages.x86_64-linux.complete.withComponents [
            "cargo"
            "clippy"
            "rust-src"
            "rustc"
            "rustfmt"
          ]
        )
      ];
    };
  };
}
