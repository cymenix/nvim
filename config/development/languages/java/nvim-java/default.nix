{pkgs, ...}: let
  nvim-java = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-java";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-java";
      repo = "nvim-java";
      rev = "b3174e41ab51867123d8663eced53b33f1548522";
      hash = "sha256-dKn4DaaacRRf9VrgN9TiTnxdqKnlmwCsr51DyAAAEeY=";
    };
  };
in {
  programs = {
    nixvim = {
      extraPlugins = [
        nvim-java
        pkgs.vimPlugins.nvim-jdtls
      ];
      extraConfigLuaPost =
        /*
        lua
        */
        ''
          require('java').setup()
          require('lspconfig').jdtls.setup({})
        '';
      plugins = {
        which-key = {
          settings = {
            spec = [
              {
                __unkeyed-1 = "<leader>cj";
                group = "+Java";
              }
              {
                __unkeyed-1 = "<leader>cjrm";
                desc = "Runs the application or selected main class (if there are multiple main classes)";
              }
              {
                __unkeyed-1 = "<leader>cjsm";
                desc = "Stops the running application";
              }
              {
                __unkeyed-1 = "<leader>cjbw";
                desc = "Runs a full workspace build";
              }
              {
                __unkeyed-1 = "<leader>cjcw";
                desc = "Clear the workspace cache (requires restart of the language server)";
              }
              {
                __unkeyed-1 = "<leader>cjtl";
                desc = "Toggle between show & hide runner log window";
              }
              {
                __unkeyed-1 = "<leader>cjd";
                desc = "Force DAP configuration";
              }
              {
                __unkeyed-1 = "<leader>cjtrcc";
                desc = "Run the test class in the active buffer";
              }
              {
                __unkeyed-1 = "<leader>cjtdcc";
                desc = "Debug the test class in the active buffer";
              }
              {
                __unkeyed-1 = "<leader>cjtrcm";
                desc = "Run the test method on the cursor";
              }
              {
                __unkeyed-1 = "<leader>cjtdcm";
                desc = "Debug the test method on the cursor";
              }
              {
                __unkeyed-1 = "<leader>cjtv";
                desc = "Open the last test report in a popup window";
              }
              {
                __unkeyed-1 = "<leader>cjp";
                desc = "Opens the profiles UI";
              }
              {
                __unkeyed-1 = "<leader>cjrev";
                desc = "Create a variable from value at cursor/selection";
              }
              {
                __unkeyed-1 = "<leader>cjreva";
                desc = "Create a variable for all occurrences from value at cursor/selection";
              }
              {
                __unkeyed-1 = "<leader>cjrec";
                desc = "Create a constant from the value at cursor/selection";
              }
              {
                __unkeyed-1 = "<leader>cjrem";
                desc = "Create a method from the value at cursor/selection";
              }
              {
                __unkeyed-1 = "<leader>cjref";
                desc = "Create a field from the value at cursor/selection";
              }
              {
                __unkeyed-1 = "<leader>cjs";
                desc = "Change the JDK version to another";
              }
            ];
          };
        };
      };
      keymaps = [
        {
          action = ":JavaRunnerRunMain<CR>";
          key = "<leader>cjrm";
          mode = "n";
          options = {
            desc = "Runs the application or selected main class (if there are multiple main classes)";
            silent = true;
          };
        }
        {
          action = ":JavaRunnerStopMain<CR>";
          key = "<leader>cjsm";
          mode = "n";
          options = {
            desc = "Stops the running application";
            silent = true;
          };
        }
        {
          action = ":JavaRunnerBuildWorkspace<CR>";
          key = "<leader>cjbw";
          mode = "n";
          options = {
            desc = "Runs a full workspace build";
            silent = true;
          };
        }
        {
          action = ":JavaRunnerCleanWorkspace<CR>";
          key = "<leader>cjcw";
          mode = "n";
          options = {
            desc = "Clear the workspace cache (for now you have to close and reopen to restart the language server after the deletion)";
            silent = true;
          };
        }
        {
          action = ":JavaRunnerToggleLogs<CR>";
          key = "<leader>cjtl";
          mode = "n";
          options = {
            desc = "Toggle between show & hide runner log window";
            silent = true;
          };
        }
        {
          action = ":JavaDapConfig<CR>";
          key = "<leader>cjd";
          mode = "n";
          options = {
            desc = "DAP is autoconfigured on start up, but in case you want to force configure it again, you can use this API";
            silent = true;
          };
        }
        {
          action = ":JavaTestRunCurrentClass<CR>";
          key = "<leader>cjtrcc";
          mode = "n";
          options = {
            desc = "Run the test class in the active buffer";
            silent = true;
          };
        }
        {
          action = ":JavaTestDebugCurrentClass<CR>";
          key = "<leader>cjtdcc";
          mode = "n";
          options = {
            desc = "Debug the test class in the active buffer";
            silent = true;
          };
        }
        {
          action = ":JavaTestRunCurrentMethod<CR>";
          key = "<leader>cjtrcm";
          mode = "n";
          options = {
            desc = "Run the test method on the cursor";
            silent = true;
          };
        }
        {
          action = ":JavaTestDebugCurrentMethod<CR>";
          key = "<leader>cjtdcm";
          mode = "n";
          options = {
            desc = "Debug the test method on the cursor";
            silent = true;
          };
        }
        {
          action = ":JavaTestViewLastReport<CR>";
          key = "<leader>cjtv";
          mode = "n";
          options = {
            desc = "Open the last test report in a popup window";
            silent = true;
          };
        }
        {
          action = ":JavaProfile<CR>";
          key = "<leader>cjp";
          mode = "n";
          options = {
            desc = "Opens the profiles UI";
            silent = true;
          };
        }
        {
          action = ":JavaRefactorExtractVariable<CR>";
          key = "<leader>cjrev";
          mode = "n";
          options = {
            desc = "Create a variable from value at cursor/selection";
            silent = true;
          };
        }
        {
          action = ":JavaRefactorExtractVariableAllOccurrence<CR>";
          key = "<leader>cjreva";
          mode = "n";
          options = {
            desc = "Create a variable for all occurrences from value at cursor/selection";
            silent = true;
          };
        }
        {
          action = ":JavaRefactorExtractConstant<CR>";
          key = "<leader>cjrec";
          mode = "n";
          options = {
            desc = "Create a constant from the value at cursor/selection";
            silent = true;
          };
        }
        {
          action = ":JavaRefactorExtractMethod<CR>";
          key = "<leader>cjrem";
          mode = "n";
          options = {
            desc = "Create a method from the value at cursor/selection";
            silent = true;
          };
        }
        {
          action = ":JavaRefactorExtractField<CR>";
          key = "<leader>cjref";
          mode = "n";
          options = {
            desc = "Create a field from the value at cursor/selection";
            silent = true;
          };
        }
        {
          action = ":JavaSettingsChangeRuntime<CR>";
          key = "<leader>cjs";
          mode = "n";
          options = {
            desc = "Change the JDK version to another";
            silent = true;
          };
        }
      ];
    };
  };
}
