inputs: {
  nixpkgs,
  system,
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.editor.nixvim;
  flake = osConfig.modules.users.flake;
  pkgs = import nixpkgs {
    inherit system;
    overlays = with inputs; [
      neorg-overlay.overlays.default
    ];
  };
in
  with lib; {
    options = {
      modules = {
        editor = {
          nixvim = {
            neorg = {
              enable = mkEnableOption "Enable neorg for nixvim" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.neorg.enable) {
      programs = {
        nixvim = {
          extraPlugins = with pkgs.vimPlugins; [neorg neorg-telescope];
          extraConfigLuaPost =
            /*
            lua
            */
            ''
              require("neorg").setup {
                load = {
                  ["core.defaults"] = {},
                  ["core.concealer"] = {},
                  ["core.dirman"] = {
                    config = {
                      workspaces = {
                        notes = "${config.home.homeDirectory}/${flake}/notes"
                      },
                      default_workspaces = "notes",
                    },
                  },
                },
              }
              vim.wo.foldlevel = 99;
              vim.wo.conceallevel = 2;
            '';
          keymaps = [
            {
              action = ":Neorg<CR>";
              key = "<leader>nt";
              mode = "n";
              options = {
                silent = true;
                desc = "Toggle Neorg";
              };
            }
          ];
          plugins = {
            which-key = {
              settings = {
                spec = [
                  {
                    __unkeyed-1 = "<leader>n";
                    group = "+Neorg";
                  }
                  {
                    __unkeyed-1 = "<leader>nt";
                    desc = "Toggle neorg";
                  }
                ];
              };
            };
          };
        };
      };
    };
  }
