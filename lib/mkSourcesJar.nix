{ openjdk
, stdenv
, mkJavaDerivation
}:

args@{ pname, version, src, packagesPath, ... }:

mkJavaDerivation (args // {
  command = ''
    jar --create \
      --file target/deploy/${pname}-${version}-sources.jar \
      -C ${packagesPath} .
  '';
})
