{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPackages = with pkgs; [
        prettierd
        stylua
        alejandra
        rustfmt
        haskellPackages.cabal-fmt
      ];
      keymaps = [
        {
          action.__raw =
            /*
            lua
            */
            ''
              function()
                require("conform").format({ async = true, lsp_fallback = true })
              end
            '';
          key = "<leader>i";
          mode = "n";
          options = {
            silent = true;
            desc = "Format";
          };
        }
      ];
      plugins = {
        conform-nvim = {
          enable = true;
          settings = {
            formatters_by_ft = {
              nix = ["alejandra"];
              rust = ["rustfmt"];
              javascript = ["prettierd"];
              typescript = ["prettierd"];
              javascriptreact = ["prettierd"];
              typescriptreact = ["prettierd"];
              css = ["prettierd"];
              html = ["prettierd"];
              json = ["prettierd"];
              yaml = ["prettierd"];
              graphql = ["prettierd"];
              markdown = ["prettierd"];
            };
          };
        };
        which-key = {
          settings = {
            spec = [
              {
                __unkeyed-1 = "<leader>i";
                desc = "Format";
              }
            ];
          };
        };
      };
    };
  };
}
