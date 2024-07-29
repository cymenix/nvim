{pkgs, ...}: {
  imports = [
    ./ts-autotag
    ./ts-context-commentstring
  ];
  programs = {
    nixvim = {
      plugins = {
        treesitter = {
          enable = true;
          package = pkgs.treesitter.overrideAttrs (oldAttrs: rec {
            version = "0.22.5";
            src = pkgs.fetchFromGitHub {
              inherit (oldAttrs.src) owner repo fetchSubmodules;
              rev = "v${version}";
              sha256 = "sha256-44FIO0kPso6NxjLwmggsheILba3r9GEhDld2ddt601g=";
            };
          });
          nixvimInjections = true;
          nixGrammars = true;
        };
      };
    };
  };
}
