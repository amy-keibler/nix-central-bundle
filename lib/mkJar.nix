{ openjdk
, stdenv
, mkJavaDerivation
}:

args@{ pname, version, src, packagePath, ... }:

mkJavaDerivation (args // {
  command = ''
    javac -d target/classes -g --release 17 ${packagePath}/**/*.java
    jar --create \
      --file target/deploy/${pname}-${version}.jar \
      -C target/classes .
  '';
})
