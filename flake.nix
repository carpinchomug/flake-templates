{
  description = "A collection of flake templates";

  outputs = { self }: {
    templates = {
      quickpython = {
        path = ./quickpython;
        description = "nix shell with python for quick maths, prototyping, etc.";
      };
    };
  };
}
