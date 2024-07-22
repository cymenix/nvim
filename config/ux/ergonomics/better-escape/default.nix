{...}: {
  programs = {
    nixvim = {
      plugins = {
        better-escape = {
          enable = false;
          mapping = ["jj" "jk"];
        };
      };
    };
  };
}
