{
  description = "A collection of flake templates";

  outputs = { self }: {
    templates = {
      python-pure = {
        path = ./python-impure;
        description = "manage python environment with nix";
      };

      python-impure = {
        path = ./python-impure;
        description = "manage python environment with nix + pip";
      };
    };
  };
}
