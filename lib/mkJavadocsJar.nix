{ openjdk
, stdenv
, mkJavaDerivation
}:

args@{ pname, version, src, packagePath, ... }:

mkJavaDerivation (args // {
  command = ''
    javadoc -d target/doc ${packagePath}/**/*.java
    jar --create \
      --file target/deploy/${pname}-${version}-javadoc.jar \
      -C target/doc .
  '';
})
