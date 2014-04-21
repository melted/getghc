cabal update
cabal install alex happy
git clone https://github.com/ghc/ghc.git
cd ghc && ./sync-all --nofib --extra get
./boot
