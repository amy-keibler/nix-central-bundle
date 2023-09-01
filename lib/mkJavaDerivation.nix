{ openjdk
, stdenv
}:

args@{ pname, version, src, command, ... }:
let
  chosenStdenv = args.stdenv or stdenv;
  cleanedArgs = builtins.removeAttrs args [
    "packageRoot"
  ];

  packageRoot = args.packageRoot or "src/main/java";
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
    mkdir -p $out

    cp target/deploy/* $out/
  '';
})
