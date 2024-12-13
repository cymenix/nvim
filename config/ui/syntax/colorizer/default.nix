{...}: {
  programs = {
    nixvim = {
      plugins = {
        colorizer = {
          enable = true;
          userDefaultOptions = {
            names = false;
          };
        };
      };
    };
  };
}
