{...}: {
  programs = {
    nixvim = {
      plugins = {
        better-escape = {
          enable = false;
          settings = {
            mapping = ["jj" "jk"];
          };
        };
      };
    };
  };
}
