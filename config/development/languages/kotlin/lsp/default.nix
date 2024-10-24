{pkgs, ...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          servers = {
            kotlin-language-server = {
              enable = true;
              autostart = true;
              cmd = ["${pkgs.kotlin-language-server}/bin/kotlin-language-server"];
              filetypes = ["kotlin" "kt"];
              settings = {
                kotlin = {
                  compiler = {
                    target = {
                      jvm = "1.8";
                    };
                  };
                  languageServer = {
                    path = "${pkgs.kotlin-language-server}/bin/kotlin-language-server";
                  };
                };
              };
            };
          };
        };
        conform-nvim = {
          settings = {
            formatters_by_ft = {
              kotlin = ["ktlint"];
            };
          };
        };
      };
      extraPlugins = with pkgs.vimPlugins; [kotlin-vim];
      # extraConfigLuaPost = ''
      #   require('lspconfig').kotlin_language_server.setup{
      #     root_dir = vim.fs.root(0, {".git", "gradle.lock"}),
      #     cmd = { "kotlin-language-server" }
      #   }
      # '';
      # autoCmd = [
      #   {
      #     event = ["FileType"];
      #     pattern = "kotlin";
      #     callback = {
      #       __raw =
      #         /*
      #         lua
      #         */
      #         ''
      #           function()
      #             require('lspconfig').kotlin_language_server.setup{
      #               cmd = { "${pkgs.kotlin-language-server}/bin/kotlin-language-server" },
      #               settings = {
      #                 kotlin = {
      #                   compiler = {
      #                     target = {
      #                       jvm = "1.8"
      #                     }
      #                   },
      #                   languageServer = {
      #                     path = "${pkgs.kotlin-language-server}/bin/kotlin-language-server"
      #                   }
      #                 }
      #               }
      #             }
      #           end
      #         '';
      #     };
      #   }
      # ];
    };
  };
}
