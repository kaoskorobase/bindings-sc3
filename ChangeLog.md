### v0.4.0

* Include SuperCollider API header files in the package
* Don't depend on `libscsynth` at build time in order to enable building
  the API documentation on Hackage. This means that library users need to link
  explicitly against `libscsynth`.

### v0.3.0

* Add `mSharedMemoryID` to `C'WorldOptions`
* **Require SuperCollider 3.5**
