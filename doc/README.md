# ShoestringLinux

A low-budget [PunyLinux](https://github.com/RyanScottLewis/punylinux) distribution.

## Packages

* [GNU coreutils](https://www.gnu.org/software/coreutils/)
* [glibc](https://www.gnu.org/software/libc/)
* [Zsh](http://www.zsh.org/)
* [BusyBox](https://www.busybox.net/)

> Also includes each package's dependencies

## TODO

* Use [musl](http://www.musl-libc.org/) instead of `glibc`
* Use [Systemd](https://www.freedesktop.org/wiki/Software/systemd/) instead of `busybox` (`init` applet, `mdev` applet)
* Use [inetutils](https://www.gnu.org/software/inetutils/) instead of `busybox` (`hostname` applet)
* Use [util-linux](https://en.wikipedia.org/wiki/Util-linux) instead of `busybox` (`mount` applet)

## Contributing

1. Fork it (<https://github.com/RyanScottLewis/shoestringlinux/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Ryan Scott Lewis](https://github.com/RyanScottLewis) - creator and maintainer

