{ stdenv
, mkJar
, mkJavadocsJar
, mkSourcesJar

, coreutils
}:

{ componentNamespace
, componentName
, componentVersion
, srcRoot
, ...
}@args:
let
  chosenStdenv = args.stdenv or stdenv;

  cleanedArgs = builtins.removeAttrs args [
    "componentNamespace"
    "componentName"
    "componentVersion"
    "srcRoot"
    "jarFile"
    "docsJarFile"
    "sourcesJarFile"
  ];

  packageName = "${componentNamespace}.${componentName}";

  namespaceFolders = builtins.replaceStrings [ "." ] [ "/" ] componentNamespace;
  outputFolder = "output/${namespaceFolders}";
  jarBaseName = "${componentName}-${componentVersion}";

  jarCommonArgs = {
    version = componentVersion;
    src = srcRoot;
    packagePath = namespaceFolders;
  };

  jarFile = args.jarFile or (mkJar (jarCommonArgs // {
    pname = "${packageName}-jar";
  }));
  docsJarFile = args.docsJarFile or (mkJavadocsJar (jarCommonArgs // {
    pname = "${packageName}-docs";
  }));
  sourcesJarFile = args.sourcesJarFile or (mkJar (jarCommonArgs // {
    pname = "${packageName}-sources";
  }));

  generateHashesCommands = fileName: ''
    md5sum --binary ${outputFolder}/${fileName} | cut --fields 1 --delimiter " " > ${outputFolder}/${fileName}.md5
    sha1sum --binary ${outputFolder}/${fileName} | cut --fields 1 --delimiter " " > ${outputFolder}/${fileName}.sha1
    sha256sum --binary ${outputFolder}/${fileName} | cut --fields 1 --delimiter " " > ${outputFolder}/${fileName}.sha256
    sha512sum --binary ${outputFolder}/${fileName} | cut --fields 1 --delimiter " " > ${outputFolder}/${fileName}.sha512
  '';
in
chosenStdenv.mkDerivation (cleanedArgs // {
  pname = packageName;
  version = componentVersion;

  dontUnpack = true;

  nativeBuildInputs = [
    coreutils
  ];

  buildPhase = ''
    mkdir --parents ${outputFolder}

    cp ${jarFile} ${outputFolder}/${jarBaseName}.jar
    cp ${docsJarFile} ${outputFolder}/${jarBaseName}-javadoc.jar
    cp ${sourcesJarFile} ${outputFolder}/${jarBaseName}-sources.jar
    ${generateHashesCommands "${jarBaseName}.jar"}
    ${generateHashesCommands "${jarBaseName}-javadoc.jar"}
    ${generateHashesCommands "${jarBaseName}-sources.jar"}
  '';

  installPhase = ''
    mkdir --parents $out
    cp --recursive output/* $out
  '';
})
