{ stdenv
, zip
}:

args@{ pname, version, components, ... }:
let
  chosenStdenv = args.stdenv or stdenv;

  cleanedArgs = builtins.removeAttrs args [
    "components"
  ];

  zipCommands = builtins.concatStringsSep "\n" ((builtins.map (files: "cp --recursive ${files}/* .") components) ++ [ "zip -x env-vars -r bundle.zip *" ]);
in
chosenStdenv.mkDerivation (cleanedArgs // {
  inherit pname version;

  dontUnpack = true;

  nativeBuildInputs = [
    zip
  ];

  buildPhase = zipCommands;

  installPhase = ''
    cp bundle.zip $out
  '';
})
