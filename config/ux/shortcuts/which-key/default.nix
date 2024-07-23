{
  nixpkgs,
  system,
  ...
}: let
  pkgs = import nixpkgs {
    inherit system;
    overlays = [
      (final: prev: {
        vimPlugins.which-key-nvim = prev.vimPlugins.which-key-nvim.overrideAttrs (oldAttrs: {
          src = prev.fetchFromGitHub {
            owner = oldAttrs.src.owner;
            repo = oldAttrs.src.repo;
            rev = "0539da005b98b02cf730c1d9da82b8e8edb1c2d2"; # v2.1.0
            hash = "sha256-gc/WJJ1s4s+hh8Mx8MTDg8pGGNOXxgKqBMwudJtpO4Y=";
          };
        });
      })
    ];
  };
in {
  programs = {
    nixvim = {
      opts = {
        timeout = true;
        timeoutlen = 300;
      };
      plugins = {
        which-key = {
          enable = true;
          package = pkgs.vimPlugins.which-key-nvim;
          registrations = {
            "<Tab>" = "Next buffer";
            "<S-Tab>" = "Previous buffer";
            "<leader>h" = "Clear highlights and search term";
            "<leader>o" = "Close all buffers except current";
            "<leader>t" = {
              name = "+Toggle";
            };
          };
        };
      };
    };
  };
}
