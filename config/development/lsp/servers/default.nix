{
  config,
  lib,
  ...
}: let
  cfg = config.modules.editor.nixvim.development.lsp;
in
  with lib; {
    imports = [
      ./aiken
      ./angular
      ./bash
      ./c
      ./cmake
      ./css
      ./docker
      ./emmet
      ./html
      ./json
      ./eslint
      ./lua
      ./markdown
      ./nix
      ./nx
      ./tailwind
      ./typescript
      ./yaml
      ./python
      ./tex
    ];
    options = {
      modules = {
        editor = {
          nixvim = {
            development = {
              lsp = {
                servers = {
                  enable = mkEnableOption "Enable custom language servers" // {default = cfg.enable;};
                };
              };
            };
          };
        };
      };
    };
  }
