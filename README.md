**bindings-sc3** is a Haskell library that provides low-level bindings to the [SuperCollider][] synthesis engine library `libscsynth`.

### Installation

Currently, **bindings-sc3** requires [SuperCollider][] to be built from source (at least revision `12838871d99ff72cfa047aa07e1a53ba2b1c8f5b`). See the [SuperCollider development page][sc_development] for information on how to get the sources from the git repository and build SuperCollider (you need to pass `-DLIBSCSYNTH=ON` to `cmake` in order to build the shared library).

#### MacOS X

Assuming the environment variable `SC` points to the SuperCollider source tree, the bindings can then be installed as follows:

    DYLD_LIBRARY_PATH=$SC/server/scsynth \
        cabal install --extra-include-dirs=$SC/include/common \
                      --extra-include-dirs=$SC/include/plugin_interface \
                      --extra-include-dirs=$SC/include/server \
                      --extra-lib-dirs=$SC/server/scsynth/

### Reporting bugs

Please report bugs in our [issue tracker][issues].

### Development

**bindings-sc3**'s source code is hosted at [github][]. You can check out a copy of the repository with the following command:

    git://github.com/kaoskorobase/bindings-sc3.git

[supercollider]: http://supercollider.sourceforge.net/
[sc_development]: http://supercollider.sourceforge.net/developers/
[issues]: https://github.com/kaoskorobase/bindings-sc3/issues/
[github]: https://github.com/kaoskorobase/bindings-sc3/
