{...}: {
  programs = {
    nixvim = {
      plugins = {
        crates = {
          enable = true;
        };
      };
    };
  };
}
