let

  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/7db611f2af869bac6e31ba814a5593c52d54ec19.tar.gz";
    sha256 = "0yp97ayg3bbi2bm2sgvjhrrmc73hqpv4cymm7gb49mmqjwg5fzws";
  }) {};

  hie = (import (builtins.fetchTarball {
    url = "https://github.com/infinisil/hie-nix/archive/afbe6a889c177e92a10b2b8dceeeabdcf2f2e4fe.tar.gz";
    sha256 = "1ar0h12ysh9wnkgnvhz891lvis6x9s8w3shaakfdkamxvji868qa";
  }) {}).hie84;

  emacs = pkgs.emacsWithPackages (p: [ p.lsp-haskell ]);

  hpkgs = pkgs.haskellPackages;

in

{
  inherit hie;

  env = pkgs.mkShell {
    buildInputs = [ hpkgs.cabal-install hpkgs.ghc pkgs.nix pkgs.procps ];
  };

  pkg = { dir }: (hpkgs.callCabal2nix "test" dir {}).env.overrideAttrs (old: {
    buildInputs = old.buildInputs or [] ++ [ hpkgs.cabal-install emacs hie ];
  });
}
