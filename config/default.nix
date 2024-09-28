inputs: {
  nixpkgs,
  system,
  config,
  lib,
  ...
}: let
  cfg = config.modules.editor;
  pkgs = import nixpkgs {
    inherit system;
    overlays = with inputs; [
      neovim-nightly-overlay.overlays.default
      neorg-overlay.overlays.default
    ];
  };
in
  with lib; {
    imports = [
      inputs.nixvim.homeManagerModules.nixvim
      ./core
      (import ./development inputs)
      ./ui
      (import ./ux inputs)
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
    config = mkIf cfg.nixvim.enable {
      programs = {
        nixvim = {
          enable = cfg.nixvim.enable;
          package = pkgs.neovim;
          enableMan = true;
          vimAlias = false;
          viAlias = false;
          type = "lua";
          colorscheme = "catppuccin";
        };
      };
    };
  }
