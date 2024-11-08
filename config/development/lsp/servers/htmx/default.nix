{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
            htmx = {
              enable = true;
              extraOptions = {};
              filetypes = [
                "html"
              ];
            };
          };
        };
      };
    };
  };
}
