{
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.editor;
in
  with lib; {
    imports = [
      inputs.nixvim.homeManagerModules
      ./core
      ./development
      ./ui
      ./ux
      ./vcs
    ];
    options = {
      modules = {
        editor = {
          nixvim = {
            enable = mkEnableOption "Enable an amazing neovim setup" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.nixvim.enable) {
      programs = {
        nixvim = {
          enable = cfg.nixvim.enable;
          enableMan = true;
          vimAlias = false;
          viAlias = false;
          wrapRc = true;
          type = "lua";
          colorscheme = "catppuccin";
        };
      };
    };
  }
