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
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
    neorg-overlay = {
      url = "github:nvim-neorg/nixpkgs-neorg-overlay";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
    aiken = {
      url = "github:aiken-lang/aiken";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
  };

  outputs = {...} @ inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system: let
        inherit (inputs) nixpkgs;
        pkgs = import nixpkgs {inherit system;};
      in {
        inputs = {
          inherit
            (inputs)
            nixvim
            neorg-overlay
            aiken
            ;
        };
        homeManagerModules = {
          default = import ./config;
        };
        formatter = pkgs.alejandra;
      }
    );
}
