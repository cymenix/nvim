{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPackages = with pkgs; [ripgrep fd];
      extraPlugins = with pkgs.vimPlugins; [telescope-manix];
      extraConfigLuaPost =
        /*
        lua
        */
        ''
          local telescope = require('telescope')
          telescope.load_extension('manix')
        '';
      plugins = {
        telescope = {
          enable = true;
          extensions = {
            fzf-native = {
              enable = true;
              settings = {
                caseMode = "smart_case";
                fuzzy = true;
              };
            };
          };
          highlightTheme = "catppuccin";
          keymaps = {};
          settings = {};
        };
        which-key = {
          settings = {
            spec = [
              {
                __unkeyed-1 = "<leader>f";
                group = "+Telescope";
              }
              {
                __unkeyed-1 = "<leader>ff";
                desc = "Find files";
              }
              {
                __unkeyed-1 = "<leader>fg";
                desc = "Live grep";
              }
              {
                __unkeyed-1 = "<leader>fp";
                desc = "Projects";
              }
              {
                __unkeyed-1 = "<leader>fn";
                desc = "Nix";
              }
            ];
          };
        };
      };
      keymaps = [
        {
          action.__raw =
            /*
            lua
            */
            ''
              function()
                require('telescope').extensions.manix.manix({
                  manix_args = {
                  '--source','nixpkgs-doc',
                  '--source','nixpkgs-comments',
                  '--source','nixpkgs-tree',
                  '--source','hm-options',
                  '--source','nixos-options',
                  },
                  cword = false
                })
              end'';
          key = "<leader>fn";
          mode = "n";
          options = {
            silent = true;
            desc = "Nix documentation";
          };
        }
        {
          action = ":Telescope find_files<CR>";
          key = "<leader>ff";
          mode = "n";
          options = {
            silent = true;
            desc = "Find files";
          };
        }
        {
          action = ":Telescope live_grep<CR>";
          key = "<leader>fg";
          mode = "n";
          options = {
            silent = true;
            desc = "Live grep";
          };
        }
        {
          action = ":Telescope projects<CR>";
          key = "<leader>fp";
          mode = "n";
          options = {
            silent = true;
            desc = "Projects";
          };
        }
      ];
    };
  };
}
