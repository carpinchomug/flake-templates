{
  description = "A collection of flake templates";

  outputs = { self }: {
    templates = {
      clang = {
        path = ./clang;
        description = "C/C++ template that includes a development shell for a clang-based project.";
      };

      python = {
        path = ./python;
        description = "Python environment for data science";
      };
    };
  };
}
