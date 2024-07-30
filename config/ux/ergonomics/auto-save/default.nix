{...}: {
  programs = {
    nixvim = {
      plugins = {
        auto-save = {
          enable = true;
          settings = {
            writeAllBuffers = true;
            extraOptions = {};
          };
        };
      };
    };
  };
}
