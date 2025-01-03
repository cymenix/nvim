{
  config,
  lib,
  ...
}: let
  cfg = config.modules.editor.nixvim;
in {
  imports = [
    ./autocommands
    ./clipboard
    ./editorconfig
    ./filetypes
    ./globals
    ./keymaps
    ./options
  ];
  options = {
    modules = {
      editor = {
        nixvim = {
          core = {
            enable = lib.mkEnableOption "Enable core neovim configuration" // {default = cfg.enable;};
          };
        };
      };
    };
  };
}
