{
  config,
  lib,
  ...
}: let
  cfg = config.modules.editor.nixvim.ui;
in
  with lib; {
    imports = [
      ./mini-icons
    ];
    options = {
      modules = {
        editor = {
          nixvim = {
            ui = {
              icons = {
                enable = mkEnableOption "Enable icons" // {default = cfg.enable;};
              };
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.icons.enable) {
      programs = {
        nixvim = {
          plugins = {
            web-devicons = {
              inherit (cfg.icons) enable;
            };
          };
        };
      };
    };
  }
