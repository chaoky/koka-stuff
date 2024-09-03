{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell {
          shellHook = ''
            export CPATH="${pkgs.koka}/share/koka/v3.1.2/kklib/include"
          '';
          packages = with pkgs; [
            koka
            wasmtime
            emscripten
            nodePackages.serve
            cargo-watch
          ];
        };
      };

      packages.${system} = {
        default = pkgs.hello;
      };

      formatter = pkgs.nixfmt;
    };
}
