{...}: {
  programs = {
    nixvim = {
      plugins = {
        clangd-extensions = {
          enable = true;
          enableOffsetEncodingWorkaround = true;
        };
        lsp = {
          servers = {
            clangd = {
              enable = true;
              autostart = true;
              cmd = [
                "clangd"
                "--pretty"
                "--background-index"
                "--clang-tidy"
                "--compile-commands-dir=build"
              ];
              filetypes = [
                "c"
                "h"
                "cpp"
                "hpp"
                "objc"
                "objcpp"
                "cuda"
                "proto"
              ];
            };
          };
        };
      };
    };
  };
}
