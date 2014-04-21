pacman -Syu --noconfirm
pacman -S --noconfirm git curl tar gzip binutils autoconf make libtool automake xz
curl http://www.haskell.org/cabal/release/cabal-install-1.18.0.2/cabal.exe
mv cabal.exe ~/bin
