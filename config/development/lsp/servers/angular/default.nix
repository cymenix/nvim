{pkgs, ...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          postConfig =
            /*
            lua
            */
            ''
              local lsp = require('lspconfig')
              lsp["angularls"].setup({
                cmd = { "${pkgs.angular-language-server}/bin/ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" },
                file_types = { "component.html", "component.ts"  },
                root_dir = lsp.util.root_pattern(".angular"),
              })
            '';
        };
      };
    };
  };
}
