# nix-central-bundle

This repository is an experiment in creating bundles to publish to Maven Central with [Nix](https://nixos.org/). The
intent is to create valid Java packages without the use of Maven, Gradle, or another build tool.

This is a proof of concept that will likely never be actually useful in practice, but hopefully it at least can serve as
a learning resource.

## Inspirations

This is sort of a bibliography section to give the credit to the resources that made this effort possible, whether by
providing inspiration, documentation, or examples.

- A blog article "[Publish a Java library to Maven Central without Maven or
  Gradle](https://mccue.dev/pages/6-1-22-upload-to-maven-central)" that covers the process of generating a bundle with
  only raw `java` utilities
- The [Maven Central publishing documentation](https://central.sonatype.org/publish/) to ensure that the bundle conforms
  to all publishing requirements
- The implementation of the Rust Nix library [Crane](https://github.com/ipetkov/crane), which I used to understand how
  to add functions to a flake so they can be used by other flakes
