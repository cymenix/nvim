{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
            ts-ls = {
              enable = true;
              extraOptions = {};
              rootDir =
                /*
                lua
                */
                ''
                  require('lspconfig').util.root_pattern(".git")
                '';
            };
          };
        };
      };
    };
  };
}
