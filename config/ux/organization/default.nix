{
  config,
  lib,
  ...
}: let
  cfg = config.modules.editor.nixvim.ux;
in
  with lib; {
    imports = [
      ./nx
    ];
    options = {
      modules = {
        editor = {
          nixvim = {
            ux = {
              organization = {
                enable = mkEnableOption "Enable support for organzations" // {default = cfg.enable;};
              };
            };
          };
        };
      };
    };
  }
