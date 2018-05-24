sudo yum update -y

sudo yum -y install gmp-devel freeglut-devel python-devel zlib-devel gcc m4 zlib.i686 glibc.i686 gmp.i686

sudo ln -s /usr/lib64/libgmp.so /usr/lib64/libgmp.so.3

sudo ldconfig

curl -LO https://downloads.haskell.org/~ghc/8.2.2/ghc-8.2.2-x86_64-centos67-linux.tar.xz && \
  tar xf ghc* && \
  cd ghc* && \
  ./configure --prefix=/usr && \
  sudo make install && \
  cd .. && \
  rm -rf ghc*

 
mkdir ~/bin && \
  cd ~/bin && \
  curl -LO https://www.haskell.org/cabal/release/cabal-install-2.2.0.0/cabal-install-2.2.0.0-i386-unknown-linux.tar.gz && \
  tar xf cabal* && \
  cd ..

rm -rf ~/build
mkdir ~/build
cd ~/build

cabal sandbox init && \
  cabal update && \
  cabal install --disable-documentation pandoc -fembed_data_files && \
  mv .cabal-sandbox/bin/pandoc ~ && \
  cd ~ && \
  gzip pandoc
