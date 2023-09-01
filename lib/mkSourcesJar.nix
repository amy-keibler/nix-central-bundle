{ openjdk
, stdenv
, mkJavaDerivation
}:

args@{ pname, version, src, ... }:

let
  packageRoot = args.packageRoot or "src/main/java";
in

mkJavaDerivation (args // {
  command = ''
    jar --create \
      --file target/deploy/${pname}-${version}-sources.jar \
      -C ${packageRoot} .
  '';
})
