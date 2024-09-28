{...}: {
  programs = {
    nixvim = {
      plugins = {
        project-nvim = {
          enable = true;
          enableTelescope = true;
          settings = {
            ignoreLsp = ["rust-analyzer"];
            detectionMethods = ["pattern"];
            patterns = [
              ".git"
              "nx.json"
            ];
          };
        };
      };
    };
  };
}
