{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPlugins = [pkgs.vimPlugins.kotlin-vim];
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
                  require('lspconfig').kotlin_language_server.setup{
                    capabilities = capabilities,
                    cmd = { "kotlin-language-server" },
                    filetypes = { "kotlin" },
                    kotlin = {
                      languageServer = {
                        enabled = true
                      };
                      compiler = {
                        jvm = {
                          target = "1.8";
                        }
                      };
                      trace = {
                        server = "messages"
                      }
                    }
                  }
                end
              '';
          };
        }
      ];
      plugins = {
        conform-nvim = {
          settings = {
            formatters_by_ft = {
              kotlin = ["ktlint"];
            };
          };
        };
      };
    };
  };
}
