{pkgs, ...}: let
  junit_jar = pkgs.fetchMavenArtifact {
    groupId = "org/junit/platform";
    artifactId = "junit-platform-console-standalone";
    version = "1.10.1";
    sha256 = "sha256-tC6qU9E1dtF9tfuLKAcipq6eNtr5X0JivG6W1Msgcl8=";
  };
in {
  programs = {
    nixvim = {
      extraConfigLuaPost =
        /*
        lua
        */
        ''
          require('neotest').setup {
            adapters = {
              require('rustaceanvim.neotest'),
              require('neotest-haskell'),
              require('neotest-java')({
                junit_jar = "${junit_jar}/java_share/junit-platform-console-standalone-1.10.1.jar"
              }),
              require('neotest-jest')({
                jestCommand = "jest",
                jestConfigFile = "jest.config.ts",
                cwd = function(path)
                  return vim.fn.getcwd()
                end,
              }),
            }
          }
        '';
      extraPlugins = with pkgs.vimPlugins; [
        neotest
        neotest-haskell
        neotest-jest
        neotest-java
      ];
      keymaps = [
        {
          action = ":Neotest run<CR>";
          key = "<leader>rr";
          mode = "n";
          options = {
            silent = true;
            desc = "Run nearest test";
          };
        }
        {
          action.__raw =
            /*
            lua
            */
            ''
              function()
                require('neotest').run.run({strategy = "dap"})
              end'';
          key = "<leader>rd";
          mode = "n";
          options = {
            silent = true;
            desc = "Run nearest test";
          };
        }
        {
          action = ":Neotest output-panel toggle<CR>";
          key = "<leader>to";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle test output panel";
          };
        }
        {
          action = ":Neotest summary toggle<CR>";
          key = "<leader>ts";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle test summary";
          };
        }
        {
          action = ":Neotest jump next<CR>";
          key = "<leader>rn";
          mode = "n";
          options = {
            silent = true;
            desc = "Jump to next test";
          };
        }
        {
          action = ":Neotest jump prev<CR>";
          key = "<leader>rp";
          mode = "n";
          options = {
            silent = true;
            desc = "Jump to previous test";
          };
        }
        {
          action = ":Neotest run file<CR>";
          key = "<leader>ra";
          mode = "n";
          options = {
            silent = true;
            desc = "Run all tests";
          };
        }
      ];
      plugins = {
        which-key = {
          settings = {
            spec = [
              {
                __unkeyed-1 = "<leader>r";
                group = "+Test";
              }
              {
                __unkeyed-1 = "<leader>rd";
                desc = "Debug nearest test";
              }
              {
                __unkeyed-1 = "<leader>rn";
                desc = "Jump to next test";
              }
              {
                __unkeyed-1 = "<leader>rp";
                desc = "Jump to previous test";
              }
              {
                __unkeyed-1 = "<leader>ra";
                desc = "Run all tests";
              }
            ];
          };
        };
      };
    };
  };
}
