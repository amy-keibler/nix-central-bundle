{ openjdk
, stdenv
}:

args@{ pname, version, src, command, ... }:
let
  chosenStdenv = args.stdenv or stdenv;
  cleanedArgs = builtins.removeAttrs args [
    "command"
  ];

in
chosenStdenv.mkDerivation (cleanedArgs // {
  inherit pname version src;

  nativeBuildInputs = (args.nativeBuildInputs or [ ]) ++ [
    openjdk
  ];

  buildPhase = ''
    shopt -s globstar
    mkdir target/

    ${command}
  '';

  installPhase = ''
    cp target/deploy/*.jar $out
  '';
})
