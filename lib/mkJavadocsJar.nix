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
    javadoc -d target/doc ${packageRoot}/**/*.java
    jar --create \
      --file target/deploy/${pname}-${version}-javadoc.jar \
      -C target/doc .
  '';
})
