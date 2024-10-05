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
                "cpp"
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
