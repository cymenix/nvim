{...}: {
  programs = {
    nixvim = {
      keymaps = [
        {
          action = ":Trouble<CR>";
          key = "<leader>tt";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle trouble";
          };
        }
      ];
      plugins = {
        trouble = {
          enable = true;
        };
        which-key = {
          settings = {
            spec = [
              {
                __unkeyed-1 = "<leader>tt";
                desc = "Toggle trouble";
              }
            ];
          };
        };
      };
    };
  };
}
