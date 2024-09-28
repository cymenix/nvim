inputs: {
  config,
  lib,
  ...
}: let
  cfg = config.modules.editor.nixvim;
in
  with lib; {
    imports = [
      ./buffers
      ./diagnostics
      ./ergonomics
      ./navigation
      (import ./organization inputs)
      ./search
      ./shortcuts
      ./terminal
    ];
    options = {
      modules = {
        editor = {
          nixvim = {
            ux = {
              enable = mkEnableOption "Enable great utilities that improve user experience" // {default = cfg.enable;};
            };
          };
        };
      };
    };
  }
