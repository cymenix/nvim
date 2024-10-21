{
  config,
  pkgs,
  ...
}: {
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
                      "jdtls",
                      '-Dlog.protocol=true',
                      '-Dlog.level=ALL',
                      "-configuration",
                      vim.fs.normalize("${config.home.homeDirectory}/.cache/jdtls/config"),
                      "-data",
                      vim.fs.normalize("${config.home.homeDirectory}/.cache/jdtls") .. "/" .. workspace_dir
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
