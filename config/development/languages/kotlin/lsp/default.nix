{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
            kotlin_language_server = {
              enable = true;
              autostart = true;
              filetypes = ["kotlin"];
            };
          };
        };
      };
    };
  };
}
