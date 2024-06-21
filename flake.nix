{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
    neorg-overlay = {
      url = "github:nvim-neorg/nixpkgs-neorg-overlay";
    };
    aiken = {
      url = "github:aiken-lang/aiken";
    };
  };

  outputs = {...} @ inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system: let
        inherit (inputs) nixpkgs;
        pkgs = import nixpkgs {
          inherit system;
          overlays = with inputs; [
            neovim-nightly-overlay.overlays.default
            neorg-overlay.overlays.default
          ];
        };
      in {
        inputs = inputs.${system};
        homeManagerModules = {
          default = import ./config;
        };
        formatter = pkgs.alejandra;
      }
    );
}
