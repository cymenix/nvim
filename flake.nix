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
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
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

  outputs = inputs:
    with inputs;
      flake-utils.lib.eachDefaultSystem (
        system: let
          pkgs = import nixpkgs {inherit system;};
        in {
          homeManagerModules = {
            default = import ./config inputs;
          };
          formatter = pkgs.alejandra;
        }
      );
}
