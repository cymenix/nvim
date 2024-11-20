{inputs, ...}: {
  nixpkgs,
  system,
  config,
  lib,
  ...
}: let
  cfg = config.modules.editor;
  pkgs = import nixpkgs {
    inherit system;
    overlays = [inputs.neovim-nightly-overlay.overlays.default];
  };
in
  with lib; {
    imports = [
      inputs.nixvim.homeManagerModules.nixvim
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
    config = mkIf cfg.nixvim.enable {
      programs = {
        nixvim = {
          inherit (cfg.nixvim) enable;
          package = pkgs.neovim;
          enableMan = true;
          vimAlias = false;
          viAlias = false;
          colorscheme = "catppuccin";
        };
      };
    };
  }
