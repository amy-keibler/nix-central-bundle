{ lib
, newScope
}:

lib.makeScope newScope (self:
let
  inherit (self) callPackage;
in
{
  mkJavaDerivation = callPackage ./mkJavaDerivation.nix { };
  mkJar = callPackage ./mkJar.nix { };
  mkJavadocsJar = callPackage ./mkJavadocsJar.nix { };
  mkSourcesJar = callPackage ./mkSourcesJar.nix { };
  mkJavaComponent = callPackage ./mkJavaComponent.nix { };

  mkCentralBundle = callPackage ./mkCentralBundle.nix { };
})
