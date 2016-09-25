CURR_DIR=`pwd`

cd ~

sudo yum -y install gmp-devel freeglut-devel python-devel zlib-devel gcc m4

sudo ln -s /usr/lib64/libgmp.so.10 /usr/lib64/libgmp.so.3 && sudo ldconfig

curl -LO https://downloads.haskell.org/~ghc/latest/ghc-8.0.1-x86_64-centos67-linux.tar.xz && \
  tar xf ghc* && \
  cd ghc* && \
  ./configure --prefix=/usr && \
  sudo make install && \
  cd ..

mkdir .bin && \
  cd bin && \
  curl -LO https://www.haskell.org/cabal/release/cabal-install-1.24.0.0/cabal-install-1.24.0.0-x86_64-unknown-linux.tar.gz && \
  tar xf cabal* && \
  cd ..

cd $CURR_DIR

rm -f pandoc.gz

cabal sandbox init && \
  cabal update && \
  cabal install hsb2hs && \ 
  cabal install --disable-documentation pandoc -fembed_data_files && \
  mv .cabal-sandbox/bin/pandoc ~ \
  gzip pandoc

