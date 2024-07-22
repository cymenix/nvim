{
  config,
  lib,
  ...
}: let
  cfg = config.modules.editor.nixvim.ui.icons;
  inherit (cfg) enable;
in
  with lib; {
    options = {
      modules = {
        editor = {
          nixvim = {
            ui = {
              icons = {
                mini-icons = {
                  enable = mkEnableOption "Enable mini-icons" // {default = enable;};
                };
              };
            };
          };
        };
      };
    };
    config = mkIf (enable && cfg.mini-icons.enable) {
      programs = {
        nixvim = {
          extraPlugins = with pkgs; [
            vimPlugins.mini-nvim
          ];
          extraConfigLuaPost = ''
            require('mini.icons').setup()
          '';
        };
      };
    };
  }
