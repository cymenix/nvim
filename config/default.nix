{
  pkgs,
  nixpkgs,
  system,
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.editor;
  # pkgs = import nixpkgs {
  #   inherit system;
  #   overlays = with inputs; [
  #     neovim-nightly-overlay.overlays.default
  #     (final: prev: {
  #       tree-sitter = prev.treesitter.overrideAttrs (oldAttrs: rec {
  #         version = "0.22.5";
  #         src = prev.fetchFromGitHub {
  #           inherit (oldAttrs.src) owner repo fetchSubmodules;
  #           rev = "v${version}";
  #           sha256 = "sha256-44FIO0kPso6NxjLwmggsheILba3r9GEhDld2ddt601g=";
  #         };
  #       });
  #     })
  #   ];
  # };
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
          enable = cfg.nixvim.enable;
          package = pkgs.neovim;
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
