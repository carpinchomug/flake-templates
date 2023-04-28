{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (system: with pkgs.${system};
        let
          libraries = [
            stdenv.cc.cc.lib

            # For numpy
            # zlib
          ];
        in
        {
          default = mkShell {
            venvDir = "./.venv";

            packages = [
              python3Packages.python
              python3Packages.venvShellHook
            ];

            LD_LIBRARY_PATH = "${lib.makeLibraryPath libraries}";
          };
        });
    };
}
