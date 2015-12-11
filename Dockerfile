FROM haskell:7.8
COPY clean_ /
ENV PATH /root/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.8.4/bin:/opt/happy/1.19.4/bin:/opt/alex/3.1.3/bin:$PATH
RUN apt-get update && \
    apt-get --no-install-recommends install -y \
    wget libfann-dev pkg-config g++ make autoconf xorg-dev libcairo2-dev freeglut3-dev && \
    wget http://fltk.org/pub/fltk/1.3.3/fltk-1.3.3-source.tar.gz && \
    tar xvf fltk-1.3.3-source.tar.gz && \
    cd fltk-1.3.3 && \
    ./configure --enable-gl --enable-cairo && \
    make &&  make install && cd / && \
    sh clean_ && rm clean_
RUN cabal update -v && cabal install cabal-install c2hs
RUN mkdir app
WORKDIR /app
COPY include/linker-config /usr/bin/
RUN chmod +x /usr/bin/linker-config
CMD ["bash"]
