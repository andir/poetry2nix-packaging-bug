let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {
    overlays = [
      (self: super: {
        poetry2nix = super.callPackage sources.poetry2nix {};
      })
    ];
  };
  env = pkgs.poetry2nix.mkPoetryEnv {
    python = pkgs.python3;
    pyproject = ./pyproject.toml;
    poetrylock = ./poetry.lock;
  };
in
pkgs.mkShell {
  buildInputs = [
    env
    pkgs.poetry
  ];
}
