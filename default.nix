let

  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/7db611f2af869bac6e31ba814a5593c52d54ec19.tar.gz";
    sha256 = "0yp97ayg3bbi2bm2sgvjhrrmc73hqpv4cymm7gb49mmqjwg5fzws";
  }) {};

in

with pkgs.haskellPackages;

{
  env = pkgs.mkShell {
    buildInputs = [ cabal-install ghc ];
  };
  pkg = (callCabal2nix "test" ./test {}).env.overrideAttrs (old: {
    buildInputs = old.buildInputs or [] ++ [ cabal-install ];
  });
}
