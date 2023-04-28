{
  description = "A collection of flake templates";

  outputs = { self }: {
    templates = {
      skeleton = {
        path = ./skeleton;
        description = "minimal template for making a nix shell environment";
      };

      python-impure = {
        path = ./python-impure;
        description = "manage python environment with nix + pip";
      };
    };
  };
}
