{
  config,
  lib,
  ...
}: let
  cfg = config.modules.editor.nixvim.development.languages;
in
  with lib; {
    imports = [
      ./lsp
    ];
    options = {
      modules = {
        editor = {
          nixvim = {
            development = {
              languages = {
                kotlin = {
                  enable = mkEnableOption "Enable kotlin support" // {default = cfg.enable;};
                };
              };
            };
          };
        };
      };
    };
  }
