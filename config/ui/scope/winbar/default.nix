{...}: {
  programs = {
    nixvim = {
      plugins = {
        barbecue = {
          enable = true;
          settings = {
            attachNavic = true;
          };
        };
        navbuddy = {
          enable = true;
          lsp = {
            autoAttach = true;
          };
        };
        navic = {
          enable = true;
          settings = {
            click = true;
            highlight = true;
            lazyUpdateContext = true;
            lsp = {
              autoAttach = true;
              preference = ["typescript" "html" "tailwind"];
            };
          };
        };
      };
      keymaps = [
        {
          action = ":Navbuddy<CR>";
          key = "<leader>tn";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle Navbuddy";
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
                __unkeyed-1 = "<leader>tn";
                desc = "Toggle Navbuddy";
              }
            ];
          };
        };
      };
    };
  };
}
