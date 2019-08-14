name      :gdbm
version   '1.18.1'
archive   "https://ftp.gnu.org/gnu/#{name}/#{name}-#{version}.tar.gz"
signature "#{archive}.sig"

on_build do |package|
  cd package.build_path do
    sh <<~EOS
      ./configure \
        --prefix=/usr \
        --enable-libgdbm-compat
    EOS

    make
  end
end

on_install do |package|
  cd package.build_path do
    os_root = paths.project_root.join(paths.os_root)

    make :install, 'DESTDIR' => os_root

    sh "install -dm755 '#{os_root}/usr/include/gdbm'"
    ln_sf '../gdbm.h', "#{os_root}/usr/include/gdbm/gdbm.h"
    ln_sf '../ndbm.h', "#{os_root}/usr/include/gdbm/ndbm.h"
    ln_sf '../dbm.h',  "#{os_root}/usr/include/gdbm/dbm.h"
  end
end

files %w(
  /usr/bin/gdbm_dump
  /usr/bin/gdbm_load
  /usr/bin/gdbmtool
  /usr/include/dbm.h
  /usr/include/gdbm.h
  /usr/include/gdbm/dbm.h
  /usr/include/gdbm/gdbm.h
  /usr/include/gdbm/ndbm.h
  /usr/include/ndbm.h
  /usr/lib/libgdbm.so
  /usr/lib/libgdbm.so.6
  /usr/lib/libgdbm.so.6.0.0
  /usr/lib/libgdbm_compat.so
  /usr/lib/libgdbm_compat.so.4
  /usr/lib/libgdbm_compat.so.4.0.0
  /usr/share/info/gdbm.info
  /usr/share/locale/da/LC_MESSAGES/gdbm.mo
  /usr/share/locale/de/LC_MESSAGES/gdbm.mo
  /usr/share/locale/eo/LC_MESSAGES/gdbm.mo
  /usr/share/locale/es/LC_MESSAGES/gdbm.mo
  /usr/share/locale/fi/LC_MESSAGES/gdbm.mo
  /usr/share/locale/fr/LC_MESSAGES/gdbm.mo
  /usr/share/locale/ja/LC_MESSAGES/gdbm.mo
  /usr/share/locale/pl/LC_MESSAGES/gdbm.mo
  /usr/share/locale/pt_BR/LC_MESSAGES/gdbm.mo
  /usr/share/locale/sr/LC_MESSAGES/gdbm.mo
  /usr/share/locale/sv/LC_MESSAGES/gdbm.mo
  /usr/share/locale/uk/LC_MESSAGES/gdbm.mo
  /usr/share/locale/vi/LC_MESSAGES/gdbm.mo
  /usr/share/man/man1/gdbm_dump.1
  /usr/share/man/man1/gdbm_load.1
  /usr/share/man/man1/gdbmtool.1
  /usr/share/man/man3/gdbm.3
)
