{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPlugins = [pkgs.vimPlugins.nvim-jdtls];
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
                  local cmp_nvim_lsp = require("cmp_nvim_lsp")
                  local client_capabilities = vim.lsp.protocol.make_client_capabilities()
                  local capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)
                  local util = require('lspconfig/util')
                  require('lspconfig').kotlin_language_server.setup{
                    capabilities = capabilities,
                    -- root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "gradle.lock", "settings.gradle.kts" }),
                    cmd = { "kotlin-language-server" },
                    init_options = {
                       storagePath = util.path.join(vim.env.XDG_DATA_HOME, "nvim-data"),
                    };
                    settings = {
                      kotlin = {
                        compiler = {
                          jvm = {
                            target = "1.8";
                          }
                        };
                      };
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
