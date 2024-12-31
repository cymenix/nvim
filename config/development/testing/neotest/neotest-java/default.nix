{pkgs ? import <nixpkgs> {}, ...}:
pkgs.vimUtils.buildVimPlugin {
  name = "neotest-java";
  doCheck = false;
  src = pkgs.fetchFromGitHub {
    owner = "clemenscodes";
    repo = "neotest-java";
    rev = "01d42c2d27a9f6396b24063ba3714ec9f71c7c80";
    hash = "sha256-W0lmSnmYhQRqQ3LVn/LWhWTpoeocGZNmvjsR6OsW21w=";
  };
}
