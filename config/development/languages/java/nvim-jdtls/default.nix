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
                  local config = {
                    capabilities = capabilities,
                    cmd = {
                      "java",
                      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                      '-Dosgi.bundles.defaultStartLevel=4',
                      '-Declipse.product=org.eclipse.jdt.ls.core.product',
                      '-Dlog.protocol=true',
                      '-Dlog.level=ALL',
                      '-Xmx1g',
                      '-jar',
                      vim.fn.glob("${jdtls}/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar", 1),
                      "-configuration",
                      vim.fs.normalize("${config.home.homeDirectory}/.cache/jdtls/config"),
                      "-data", vim.fs.root(0, {".git", "mvnw", "gradlew"})
                    },
                    root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}),
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
