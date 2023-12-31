{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };

      mkLib = pkgs: import ./lib {
        inherit (pkgs) lib newScope;
      };

    in
    rec {
      lib = mkLib pkgs;

      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          openjdk

          nixpkgs-fmt
        ];
      };
    });
}
