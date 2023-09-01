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
    javac -d target/classes -g --release 17 ${packageRoot}/**/*.java
    jar --create \
      --file target/deploy/${pname}-${version}.jar \
      -C target/classes .
  '';
})
