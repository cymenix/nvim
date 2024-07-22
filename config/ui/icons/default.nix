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
  }
