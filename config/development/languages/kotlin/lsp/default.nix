{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPlugins = [pkgs.vimPlugins.nvim-jdtls];
      plugins = {
        lsp = {
          servers = {
            kotlin-language-server = {
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
