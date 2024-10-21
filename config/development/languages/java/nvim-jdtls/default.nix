{config, ...}: {
  programs = {
    nixvim = {
      plugins = {
        nvim-jdtls = {
          enable = true;
          configuration = "${config.home.homeDirectory}/.cache/jdtls/config";
          data = "${config.home.homeDirectory}/.cache/jdtls/workspace";
        };
      };
    };
  };
}
