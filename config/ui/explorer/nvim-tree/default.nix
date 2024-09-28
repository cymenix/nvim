{pkgs, ...}: {
  programs = {
    nixvim = {
      keymaps = [
        {
          action = ":NvimTreeToggle<CR>";
          key = "<leader>e";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle nvim-tree";
          };
        }
      ];
      plugins = {
        nvim-tree = {
          enable = true;
          package = pkgs.vimPlugins.nvim-tree-lua.overrideAttrs (oldAttrs: {
            src = pkgs.fetchFromGitHub {
              owner = "nvim-tree";
              repo = "nvim-tree.lua";
              rev = "59a8a6ae5e9d3eae99d08ab655d12fd51d5d17f3";
              hash = "sha256-9oZ740EQ7d75xdjiPp62fj+Wjjq7/5gfBq3z92KkdZM=";
            };
          });
          autoClose = true;
          autoReloadOnWrite = true;
          disableNetrw = true;
          hijackCursor = true;
          syncRootWithCwd = true;
          respectBufCwd = true;
          reloadOnBufenter = true;
          preferStartupRoot = true;
          updateFocusedFile = {
            enable = true;
            updateRoot = true;
          };
          systemOpen = {
            cmd = "xdg-open";
          };
          diagnostics = {
            enable = true;
            showOnDirs = true;
          };
          filters = {
            gitClean = false;
            dotfiles = false;
          };
          git = {
            ignore = false;
          };
          onAttach = {
            __raw =
              /*
              lua
              */
              ''
                function(bufnr)
                  local api = require("nvim-tree.api")
                  local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                  end

                  local function edit_or_open()
                    local node = api.tree.get_node_under_cursor()

                    if node.nodes ~= nil then
                      -- expand or collapse folder
                      api.node.open.edit()
                    else
                      -- open file
                      api.node.open.edit()
                    end
                  end

                  -- open as vsplit on current node
                  local function vsplit_preview()
                    local node = api.tree.get_node_under_cursor()

                    if node.nodes ~= nil then
                      -- expand or collapse folder
                      api.node.open.edit()
                    else
                      -- open file as vsplit
                      api.node.open.vertical()
                    end

                    -- Finally refocus on tree if it was lost
                    api.tree.focus()
                  end
                  api.config.mappings.default_on_attach(bufnr)
                  vim.keymap.set("n", "l", edit_or_open,          opts("Edit Or Open"))
                  vim.keymap.set("n", "L", vsplit_preview,        opts("Vsplit Preview"))
                  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close folder"))
                  vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
                end
              '';
          };
          view = {
            centralizeSelection = true;
            width = {
              min = 69;
              max = 69;
              padding = 1;
            };
          };
          modified = {
            enable = true;
          };
          extraOptions = {};
        };
        which-key = {
          settings = {
            spec = [
              {
                __unkeyed-1 = "<leader>e";
                desc = "Toggle nvim-tree";
              }
            ];
          };
        };
      };
    };
  };
}
