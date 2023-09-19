{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "nixpkgs";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devShells = {
          default = pkgs.mkShell.override { stdenv = pkgs.clangStdenv; } {
            packages = with pkgs; [
              clang-tools
              cmake
            ];

            CMAKE_EXPORT_COMPILE_COMMANDS = 1;
          };
        };
      };
    };
}
