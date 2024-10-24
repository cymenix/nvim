{pkgs, ...}: {
  programs = {
    nixvim = {
      plugins = {
        # lsp = {
        #   servers = {
        #     kotlin-language-server = {
        #       enable = true;
        #       autostart = true;
        #       cmd = ["${pkgs.kotlin-language-server}/bin/kotlin-language-server"];
        #       filetypes = ["kotlin" "kt"];
        #       settings = {
        #         kotlin = {
        #           compiler = {
        #             target = {
        #               jvm = "1.8";
        #             };
        #           };
        #           languageServer = {
        #             path = "${pkgs.kotlin-language-server}/bin/kotlin-language-server";
        #           };
        #         };
        #       };
        #     };
        #   };
        # };
        conform-nvim = {
          settings = {
            formatters_by_ft = {
              kotlin = ["ktlint"];
            };
          };
        };
      };
      autoCmd = [
        {
          event = ["FileType"];
          pattern = "kotlin";
          callback = {
            __raw =
              /*
              lua
              */
              ''
                function()
                  local lsp = require('lspconfig')
                  lsp.kotlin_language_server.setup{
                    cmd = { "${pkgs.kotlin-language-server}/bin/kotlin-language-server" },
                    root_dir = lsp.util.root_pattern("gradle.lock", ".git"),
                    settings = {
                      kotlin = {
                        compiler = {
                          target = {
                            jvm = "1.8"
                          }
                        },
                        languageServer = {
                          path = "${pkgs.kotlin-language-server}/bin/kotlin-language-server"
                        }
                      }
                    }
                  }
                end
              '';
          };
        }
      ];
    };
  };
}
