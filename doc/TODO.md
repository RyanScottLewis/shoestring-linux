# TODO

## Features

* Task to check for required development dependencies
* Generate ISOLINUX image
* Sync `src/fs` into `build/`
  * Install script `src/fs/bin/install`
* Detect checksum type and use the appropriate tool (md5, sha256, sha512, etc.)
  * This could probably just be accomplished with a case statement on the checksum length
* Detect file path (`file://` URI) and load the file for sources (archive, checksum, signature)
  * If path is relative like one of the following, it is relative to the package's path (`package.path` or `package.specification_path`)
    * `file://foobar.tar`
    * `file://./foobar.tar`
* Load tasks from files within `src/tasks`
* Use fakeroot?

## Refactor

* Remove `read` from  `lib/path/import.rb`
* Prepend `has_` to query methods for `Package::Struct` (`files?` to `has_files?`)
* Load files with `**/*` for loading packages
* Whole object model is screwy
  * `Path` wraps `Pathname` which wraps `Pathname`
  * The `so-and-so/import` files feel gross
* Class method for defining `Pathname` delegates on `Path::Struct`
* Split tasks into files within `lib/tasks`
* Smarter way of setting "hidden" attributes on `Package::Struct` rather than baked into `Rakefile`
* Make it so the `linux` package is the only one required, I dont think busybox references within
  the tasks matter since I dont think we need to use Linux's `.config` file for `busybox` and just
  let it define it with `make defconfig`
* Move creation of Linux FHS directories and inital ramdisk out of the `linux` package

## Documentation

* YARDoc everywhere
* README > Usage > Package Specification - Define package DSL
* Document that a package named `linux` must be defined
