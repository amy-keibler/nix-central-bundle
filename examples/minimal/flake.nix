{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-central-bundle.url = "path:../../";
  };

  outputs = { self, nixpkgs, flake-utils, nix-central-bundle, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };

      centralBundleLib = nix-central-bundle.lib.${system};

      commonAttrs = {
        pname = "minimal";
        version = "0.0.1";
        src = ./.;
      };

    in
    {
      packages.jar = centralBundleLib.mkJar commonAttrs;

      packages.docs = centralBundleLib.mkJavadocsJar commonAttrs;

      packages.sources = centralBundleLib.mkSourcesJar commonAttrs;
    });
}
