To download the Vim plugins which are stored as git submodules, you must
run

```
git submodule update --init --recursive
```

To add a submodule

```
git submodule add git://some/url/ .vim/bundle/$BUNDLE_NAME
```
