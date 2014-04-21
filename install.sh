echo 'Setting up environment'
mkdir  ~/bin
export 
export PYTHONDIR="$(pwd)/python-2.7"
echo 'export PATH=/ghc-7.6.3/bin:$PATH'       >> ~/.bashrc
echo 'export PATH=/ghc-7.6.3/mingw/bin:$PATH' >> ~/.bashrc
echo 'export PATH=$HOME/bin:$PATH'            >> ~/.bashrc
echo 'export PATH='$PYTHONDIR':$PATH' >> ~/.bashrc
export WINHOME=`cygpath -u $HOMEPATH`
echo 'export PATH='$WINHOME'/AppData/Roaming/cabal/bin:$PATH' >> ~/.bashrc
exec bash
pacman -Syu --noconfirm
pacman -S --noconfirm git curl tar gzip binutils autoconf make libtool automake xz
curl http://www.haskell.org/cabal/release/cabal-install-1.18.0.2/cabal.exe
mv cabal.exe ~/bin
cabal update
cabal install alex happy
git clone https://github.com/ghc/ghc.git
cd ghc && ./sync-all --nofib --extra get
./boot 
