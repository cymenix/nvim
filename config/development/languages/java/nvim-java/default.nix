{pkgs, ...}: let
  owner = "nvim-java";
  nvim-java = pkgs.vimUtils.buildVimPlugin rec {
    name = owner;
    src = pkgs.fetchFromGitHub {
      inherit owner;
      repo = name;
      rev = "b3174e41ab51867123d8663eced53b33f1548522";
      hash = "sha256-dKn4DaaacRRf9VrgN9TiTnxdqKnlmwCsr51DyAAAEeY=";
    };
  };
  nvim-java-core = pkgs.vimUtils.buildVimPlugin rec {
    name = "${owner}-core";
    src = pkgs.fetchFromGitHub {
      inherit owner;
      repo = name;
      rev = "5b03dca22fee76524a89e1c2dc1d73a9f0b1a3bb";
      hash = "sha256-7DlbKmCkp2gaKEg6vDRc8p4/kzS6tJsRAHmGCwA5Ymc=";
    };
  };
  neotest-jdtls = pkgs.vimUtils.buildVimPlugin rec {
    name = "neotest-jdtls";
    src = pkgs.fetchFromGitHub {
      inherit owner;
      repo = name;
      rev = "548539665409c05607e9166872dc9472531bf725";
      hash = "sha256-kwKbswEEu6qcaYJ9DgvUbSZN5LwsJzHagm/XuLYIe5o=";
    };
  };
  nvim-java-dap = pkgs.vimUtils.buildVimPlugin rec {
    name = "${owner}-dap";
    src = pkgs.fetchFromGitHub {
      inherit owner;
      repo = name;
      rev = "55f239532f7a3789d21ea68d1e795abc77484974";
      hash = "sha256-Xrzydrlbo8B99Y1kJUri0H/3gLBHXaZ/jbIZIfhi2gU=";
    };
  };
  nvim-java-test = pkgs.vimUtils.buildVimPlugin rec {
    name = "${owner}-test";
    src = pkgs.fetchFromGitHub {
      inherit owner;
      repo = name;
      rev = "7f0f40e9c5b7eab5096d8bec6ac04251c6e81468";
      hash = "sha256-aqFg+m8EMNpQkj5aQPZaW18dtez+AsxARiEiU3ycW6I=";
    };
  };
  nvim-java-refactor = pkgs.vimUtils.buildVimPlugin rec {
    name = "${owner}-refactor";
    src = pkgs.fetchFromGitHub {
      inherit owner;
      repo = name;
      rev = "ea1420fed5463c9cc976c2b4175f434b3646f0f7";
      hash = "sha256-FC4MFHqeQBvk16iNcUkHrbsRv9lyqG1BnMkwgB21V0s=";
    };
  };
  lua-async = pkgs.vimUtils.buildVimPlugin rec {
    name = "lua-async";
    src = pkgs.fetchFromGitHub {
      inherit owner;
      repo = name;
      rev = "652d94df34e97abe2d4a689edbc4270e7ead1a98";
      hash = "sha256-SB+gmBfF3AKZyktOmPaR9CRyTyCYz2jlrxi+jgBI/Eo=";
    };
  };
  sprint-boot-nvim = pkgs.vimUtils.buildVimPlugin rec {
    name = "spring-boot.nvim";
    src = pkgs.fetchFromGitHub {
      inherit owner;
      repo = name;
      rev = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0";
      hash = "sha256-5mzAr+VS5RGLi5e+ZohrlVHUzPa+6JwEWi4cslKPMNA=";
    };
  };
in {
  programs = {
    nixvim = {
      extraPackages = with pkgs; [
        jdt-language-server
        lombok
        vscode-extensions.vscjava.vscode-java-debug
        vscode-extensions.vscjava.vscode-java-test
        vscode-extensions.vscjava.vscode-java-pack
        vscode-extensions.vscjava.vscode-maven
        vscode-extensions.vscjava.vscode-gradle
        spring-boot-cli
      ];
      extraPlugins = with pkgs.vimPlugins; [
        nvim-java
        nvim-java-core
        nvim-java-dap
        nvim-java-refactor
        nvim-java-test
        neotest-jdtls
        lua-async
        sprint-boot-nvim
        nvim-jdtls
        mason-nvim
        mason-tool-installer-nvim
        mason-lspconfig-nvim
        nui-nvim
      ];
      extraConfigLuaPost =
        /*
        lua
        */
        ''
          require("mason").setup({
            registries = {
              'github:nvim-java/mason-registry',
              'github:mason-org/mason-registry',
            },
            ui = {
              icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
              }
            }
          })
          require('java').setup({
          	--  list of file that exists in root of the project
          	root_markers = {
          		'settings.gradle',
          		'settings.gradle.kts',
          		'pom.xml',
          		'build.gradle',
          		'mvnw',
          		'gradlew',
          		'build.gradle',
          		'build.gradle.kts',
          		'.git',
          	},

          	-- load java test plugins
          	java_test = {
          		enable = true,
          	},

          	-- load java debugger plugins
          	java_debug_adapter = {
          		enable = true,
          	},

          	spring_boot_tools = {
          		enable = true,
          	},

          	jdk = {
          		-- install jdk using mason.nvim
          		auto_install = false,
          	},

          	notifications = {
          		-- enable 'Configuring DAP' & 'DAP configured' messages on start up
          		dap = true,
          	},

          	-- We do multiple verifications to make sure things are in place to run this
          	-- plugin
          	verification = {
          		-- nvim-java checks for the order of execution of following
          		-- * require('java').setup()
          		-- * require('lspconfig').jdtls.setup()
          		-- IF they are not executed in the correct order, you will see a error
          		-- notification.
          		-- Set following to false to disable the notification if you know what you
          		-- are doing
          		invalid_order = true,

          		-- nvim-java checks if the require('java').setup() is called multiple
          		-- times.
          		-- IF there are multiple setup calls are executed, an error will be shown
          		-- Set following property value to false to disable the notification if
          		-- you know what you are doing
          		duplicate_setup_calls = true,

          		-- nvim-java checks if nvim-java/mason-registry is added correctly to
          		-- mason.nvim plugin.
          		-- IF it's not registered correctly, an error will be thrown and nvim-java
          		-- will stop setup
          		invalid_mason_registry = false,
          	},
          })
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
