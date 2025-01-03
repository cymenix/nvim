{
  inputs,
  lib,
  ...
}: {
  config,
  system,
  ...
}: let
  cfg = config.modules.editor;
  pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [inputs.neovim-nightly-overlay.overlays.default];
  };
in {
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
          enable = lib.mkEnableOption "Enable an amazing neovim setup" // {default = false;};
        };
      };
    };
  };
  config = lib.mkIf cfg.nixvim.enable {
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
