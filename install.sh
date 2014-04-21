echo 'Setting up environment'
mkdir -p ~/bin
export PYTHONDIR="$(pwd)/python-2.7"
echo 'export PATH=/ghc-7.6.3/bin:$PATH'       >> ~/.bashrc
echo 'export PATH=/ghc-7.6.3/mingw/bin:$PATH' >> ~/.bashrc
echo 'export PATH=$HOME/bin:$PATH'            >> ~/.bashrc
echo 'export PATH='$PYTHONDIR':$PATH' >> ~/.bashrc
export WINHOME=`cygpath -u $HOMEPATH`
echo 'export PATH='$WINHOME'/AppData/Roaming/cabal/bin:$PATH' >> ~/.bashrc

 
