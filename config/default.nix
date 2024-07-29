{
  nixpkgs,
  system,
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.editor;
  pkgs = import nixpkgs {
    inherit system;
    overlays = with inputs; [
      (final: prev: {
        tree-sitter = prev.tree-sitter.overrideAttrs (oldAttrs: rec {
          version = "0.22.5";
          src = prev.fetchFromGitHub {
            owner = "tree-sitter";
            repo = "tree-sitter";
            rev = "v${version}";
            sha256 = "sha256-f8bdpiPNo5M8aefTmrQ2MQVg7lS0Yq7j312K1slortA=";
            fetchSubmodules = true;
          };
        });
      })
      neovim-nightly-overlay.overlays.default
    ];
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
