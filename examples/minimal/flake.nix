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

      minimumComponent = centralBundleLib.mkJavaComponent {
        componentNamespace = "io.github.amykeibler";
        componentName = "minimal";
        componentVersion = "0.1.0";
        srcRoot = src/main/java;
      };

    in
    rec {
      packages.bundle = centralBundleLib.mkCentralBundle {
        pname = "minimal-bundle";
        version = "0.0.1";

        components = [
          minimumComponent
        ];
      };
    });
}
