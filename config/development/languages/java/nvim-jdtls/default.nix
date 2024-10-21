{
  config,
  pkgs,
  ...
}: let
  jdtls = pkgs.jdt-language-server;
in {
  programs = {
    nixvim = {
      extraPlugins = [pkgs.vimPlugins.nvim-jdtls];
      autoCmd = [
        {
          event = ["FileType"];
          pattern = "java";
          callback = {
            __raw =
              /*
              lua
              */
              ''
                function()
                  local jdtls = require('jdtls')
                  local cmp_nvim_lsp = require('cmp_nvim_lsp')
                  local client_capabilities = vim.lsp.protocol.make_client_capabilities()
                  local capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)
                  local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
                  local config = {
                    capabilities = capabilities,
                    cmd = {
                      "${(pkgs.lib.getExe jdtls)}",
                      "-configuration",
                      vim.fs.normalize("${jdtls}/share/java/jdtls/config_linux"),
                      "-data", vim.fn.expand("${config.home.homeDirectory}/.cache/jdtls/workspace/" .. workspace_dir)
                    },
                    root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
                    init_options = {
                      extendedClientCapabilities = jdtls.extendedClientCapabilities,
                    }
                  }
                  jdtls.start_or_attach(config)
                end
              '';
          };
        }
      ];
    };
  };
}
