{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPlugins = with pkgs.vimPlugins; [kotlin-vim];
      extraConfigLuaPost = ''
        require('lspconfig').kotlin_language_server.setup{
          root_dir = vim.fs.root(0, {".git", "gradle.lock"}),
          cmd = { "kotlin-language-server" }
        }
      '';
      plugins = {
        conform-nvim = {
          settings = {
            formatters_by_ft = {
              kotlin = ["ktlint"];
            };
          };
        };
      };
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
      #               root_dir = vim.fs.root(0, {"gradle.lock"}),
      #               cmd = { "kotlin-language-server" }
      #             }
      #           end
      #         '';
      #     };
      #   }
      # ];
    };
  };
}
