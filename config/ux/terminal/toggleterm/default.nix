{...}: {
  programs = {
    nixvim = {
      keymaps = [
        {
          action = ":ToggleTerm<CR>";
          key = "<leader>tm";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle terminal";
          };
        }
      ];
      plugins = {
        toggleterm = {
          enable = true;
          settings = {
            direction = "float";
            closeOnExit = false;
          };
        };
        which-key = {
          settings = {
            spec = [
              {
                __unkeyed-1 = "<leader>tm";
                desc = "Toggle terminal";
              }
            ];
          };
        };
      };
    };
  };
}
