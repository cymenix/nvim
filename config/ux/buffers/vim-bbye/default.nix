{...}: {
  programs = {
    nixvim = {
      plugins = {
        vim-bbye = {
          enable = true;
          keymapsSilent = true;
          keymaps = {
            bdelete = "<leader>q";
            bwipeout = "<leader>w";
          };
        };
        which-key = {
          settings = {
            spec = [
              {
                __unkeyed-1 = "<leader>q";
                desc = "Close current buffer";
              }
              {
                __unkeyed-1 = "<leader>w";
                desc = "Wipe current buffer";
              }
            ];
          };
        };
      };
    };
  };
}
