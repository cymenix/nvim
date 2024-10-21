{
  config,
  lib,
  ...
}: let
  cfg = config.modules.editor.nixvim.development.languages;
in
  with lib; {
    imports = [
      ./nvim-java
    ];
    options = {
      modules = {
        editor = {
          nixvim = {
            development = {
              languages = {
                java = {
                  enable = mkEnableOption "Enable java support" // {default = cfg.enable;};
                };
              };
            };
          };
        };
      };
    };
  }
