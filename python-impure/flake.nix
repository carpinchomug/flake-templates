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
        venvDir = "./.venv";

        packages = with pkgs.${system}; [
          # A Python interpreter including the 'venv' module is required to
          # bootstrap the environment.
          python3Packages.python

          # This executes some shell code to initialize a venv in $venvDir
          # before dropping into the shell
          python3Packages.venvShellHook

          # Those are dependencies that we would like to use from nixpkgs,
          # which will add them to PYTHONPATH and thus make them accessible
          # from within the venv.
          python3Packages.numpy
          python3Packages.requests

          # Add more packages below as needed.
        ];

        # Run this command, only after creating the virtual environment.
        postVenvCreation = ''
          unset SOURCE_DATE_EPOCH
          if [ -f requirements.txt ]; then
            pip install -r requirements.txt
          fi
        '';

        # Now we can execute any commands within the virtual environment.
        # This is optional and can be left out to run pip manually.
        postShellHook = ''
          unset SOURCE_DATE_EPOCH
        '';
      };
    });
  };
}
