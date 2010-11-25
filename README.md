# `bindings-scsynth`: Bindings to the SuperCollider synthesis server

## Building on Linux

## Building on OSX

Assuming the environment variable `SC` points to the SuperCollider source tree, you can build SC with:

    cd $SC
    cmake CMakeLists.txt
    make
    make install

The bindings can then be built as follows:

    cabal configure --extra-include-dirs=$SC/common/Headers/{common,plugin_interface,server} --extra-lib-dirs=$SC/SuperCollider/

    DYLD_LIBRARY_PATH=$SC/SuperCollider cabal build

    runhaskell Setup.hs install
