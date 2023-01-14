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
    devShells = forAllSystems (system: with pkgs.${system}; {
      default = mkShell {
        packages = with pkgs.${system}; [
          (python3.withPackages (ps: with ps; [
            numpy
            scipy
            matplotlib
            ipython
            python-lsp-server
            python-lsp-black
            pyls-isort
          ] ++ python-lsp-server.optional-dependencies.all))
        ];
      };
    });
  };
}
