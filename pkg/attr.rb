name      :attr
version   '2.4.48'
archive   "https://download.savannah.gnu.org/releases/#{name}/#{name}-#{version}.tar.gz"
signature "#{archive}.sig"
checksum  '5ead72b358ec709ed00bbf7a9eaef1654baad937c001c044fe8b74c57f5324e7'

on_build do |package|
  package.make_build do
    <<~EOS
      ./configure \
        --libdir=/usr/lib \
        --libexecdir=/usr/lib \
        --prefix=/usr \
        --sysconfdir=/etc
    EOS
  end
end

on_install do |package|
  package.make_install
end

files %w(
  /etc/xattr.conf
  /usr/bin/attr
  /usr/bin/getfattr
  /usr/bin/setfattr
  /usr/include/attr/attributes.h
  /usr/include/attr/error_context.h
  /usr/include/attr/libattr.h
  /usr/lib/libattr.so
  /usr/lib/libattr.so.1
  /usr/lib/libattr.so.1.1.2448
  /usr/lib/pkgconfig/libattr.pc
  /usr/share/doc/attr/CHANGES
  /usr/share/doc/attr/COPYING
  /usr/share/doc/attr/COPYING.LGPL
  /usr/share/doc/attr/PORTING
  /usr/share/locale/cs/LC_MESSAGES/attr.mo
  /usr/share/locale/de/LC_MESSAGES/attr.mo
  /usr/share/locale/en@boldquot/LC_MESSAGES/attr.mo
  /usr/share/locale/en@quot/LC_MESSAGES/attr.mo
  /usr/share/locale/es/LC_MESSAGES/attr.mo
  /usr/share/locale/fr/LC_MESSAGES/attr.mo
  /usr/share/locale/gl/LC_MESSAGES/attr.mo
  /usr/share/locale/nl/LC_MESSAGES/attr.mo
  /usr/share/locale/pl/LC_MESSAGES/attr.mo
  /usr/share/locale/sv/LC_MESSAGES/attr.mo
  /usr/share/man/man1/attr.1
  /usr/share/man/man1/getfattr.1
  /usr/share/man/man1/setfattr.1
  /usr/share/man/man3/attr_get.3
  /usr/share/man/man3/attr_getf.3
  /usr/share/man/man3/attr_list.3
  /usr/share/man/man3/attr_listf.3
  /usr/share/man/man3/attr_multi.3
  /usr/share/man/man3/attr_multif.3
  /usr/share/man/man3/attr_remove.3
  /usr/share/man/man3/attr_removef.3
  /usr/share/man/man3/attr_set.3
  /usr/share/man/man3/attr_setf.3
)
