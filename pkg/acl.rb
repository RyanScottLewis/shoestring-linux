name      :acl
version   '2.2.53'
archive   "https://download.savannah.gnu.org/releases/#{name}/#{name}-#{version}.tar.gz"
signature "#{archive}.sig"
checksum  '06be9865c6f418d851ff4494e12406568353b891ffe1f596b34693c387af26c7'

on_build do |package|
  cd package.build_path do
    sh <<~EOS
      ./configure \
        --libdir=/usr/lib \
        --libexecdir=/usr/lib \
        --prefix=/usr
    EOS

    make
  end
end

on_install do |package|
  cd(package.build_path) { make :install, 'DESTDIR' => paths.project_root.join(paths.os_root) }
end

files %W(
  /usr/bin/chacl
  /usr/bin/getfacl
  /usr/bin/setfacl
  /usr/include/acl/libacl.h
  /usr/include/sys/acl.h
  /usr/lib/libacl.so
  /usr/lib/libacl.so.1
  /usr/lib/libacl.so.1.1.2253
  /usr/lib/pkgconfig/libacl.pc
  /usr/share/doc/acl/CHANGES
  /usr/share/doc/acl/COPYING
  /usr/share/doc/acl/COPYING.LGPL
  /usr/share/doc/acl/PORTING
  /usr/share/doc/acl/extensions.txt
  /usr/share/doc/acl/libacl.txt
  /usr/share/locale/de/LC_MESSAGES/acl.mo
  /usr/share/locale/en@boldquot/LC_MESSAGES/acl.mo
  /usr/share/locale/en@quot/LC_MESSAGES/acl.mo
  /usr/share/locale/es/LC_MESSAGES/acl.mo
  /usr/share/locale/fr/LC_MESSAGES/acl.mo
  /usr/share/locale/gl/LC_MESSAGES/acl.mo
  /usr/share/locale/pl/LC_MESSAGES/acl.mo
  /usr/share/locale/sv/LC_MESSAGES/acl.mo
  /usr/share/man/man1/chacl.1
  /usr/share/man/man1/getfacl.1
  /usr/share/man/man1/setfacl.1
  /usr/share/man/man3/acl_add_perm.3
  /usr/share/man/man3/acl_calc_mask.3
  /usr/share/man/man3/acl_check.3
  /usr/share/man/man3/acl_clear_perms.3
  /usr/share/man/man3/acl_cmp.3
  /usr/share/man/man3/acl_copy_entry.3
  /usr/share/man/man3/acl_copy_ext.3
  /usr/share/man/man3/acl_copy_int.3
  /usr/share/man/man3/acl_create_entry.3
  /usr/share/man/man3/acl_delete_def_file.3
  /usr/share/man/man3/acl_delete_entry.3
  /usr/share/man/man3/acl_delete_perm.3
  /usr/share/man/man3/acl_dup.3
  /usr/share/man/man3/acl_entries.3
  /usr/share/man/man3/acl_equiv_mode.3
  /usr/share/man/man3/acl_error.3
  /usr/share/man/man3/acl_extended_fd.3
  /usr/share/man/man3/acl_extended_file.3
  /usr/share/man/man3/acl_extended_file_nofollow.3
  /usr/share/man/man3/acl_free.3
  /usr/share/man/man3/acl_from_mode.3
  /usr/share/man/man3/acl_from_text.3
  /usr/share/man/man3/acl_get_entry.3
  /usr/share/man/man3/acl_get_fd.3
  /usr/share/man/man3/acl_get_file.3
  /usr/share/man/man3/acl_get_perm.3
  /usr/share/man/man3/acl_get_permset.3
  /usr/share/man/man3/acl_get_qualifier.3
  /usr/share/man/man3/acl_get_tag_type.3
  /usr/share/man/man3/acl_init.3
  /usr/share/man/man3/acl_set_fd.3
  /usr/share/man/man3/acl_set_file.3
  /usr/share/man/man3/acl_set_permset.3
  /usr/share/man/man3/acl_set_qualifier.3
  /usr/share/man/man3/acl_set_tag_type.3
  /usr/share/man/man3/acl_size.3
  /usr/share/man/man3/acl_to_any_text.3
  /usr/share/man/man3/acl_to_text.3
  /usr/share/man/man3/acl_valid.3
  /usr/share/man/man5/acl.5
)
