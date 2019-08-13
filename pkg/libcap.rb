name      :libcap
version   '2.27'
archive   "https://kernel.org/pub/linux/libs/security/linux-privs/libcap2/#{name}-#{version}.tar.xz"
signature archive.gsub(/xz$/, 'sign')

on_verify do |package|
  sh "xz -cd '#{package.archive_path}' | gpg --verify '#{package.signature_path}' -"
end

on_build do |package|
  cd(package.build_path) { make }
end

on_install do |package|
  cd(package.build_path) do
    make :install,
      'DESTDIR'       => paths.project_root.join(paths.os_root),
      'RAISE_SETFCAP' => 'no',
      'prefix'        => '/usr',
      'lib'           => '/lib',
      'bin'           => '/bin'
  end
end

files %w(
  /usr/sbin/capsh
  /usr/sbin/getcap
  /usr/sbin/getpcaps
  /usr/sbin/setcap
  /usr/include/sys/capability.h
  /usr/lib/libcap.so
  /usr/lib/libcap.so.2
  /usr/lib/libcap.so.2.27
  /usr/lib/pkgconfig/libcap.pc
  /usr/lib/security/pam_cap.so
  /usr/share/man/man1/capsh.1
  /usr/share/man/man3/cap_clear.3
  /usr/share/man/man3/cap_clear_flag.3
  /usr/share/man/man3/cap_compare.3
  /usr/share/man/man3/cap_copy_ext.3
  /usr/share/man/man3/cap_copy_int.3
  /usr/share/man/man3/cap_drop_bound.3
  /usr/share/man/man3/cap_dup.3
  /usr/share/man/man3/cap_free.3
  /usr/share/man/man3/cap_from_name.3
  /usr/share/man/man3/cap_from_text.3
  /usr/share/man/man3/cap_get_bound.3
  /usr/share/man/man3/cap_get_fd.3
  /usr/share/man/man3/cap_get_file.3
  /usr/share/man/man3/cap_get_flag.3
  /usr/share/man/man3/cap_get_pid.3
  /usr/share/man/man3/cap_get_proc.3
  /usr/share/man/man3/cap_init.3
  /usr/share/man/man3/cap_set_fd.3
  /usr/share/man/man3/cap_set_file.3
  /usr/share/man/man3/cap_set_flag.3
  /usr/share/man/man3/cap_set_proc.3
  /usr/share/man/man3/cap_size.3
  /usr/share/man/man3/cap_to_name.3
  /usr/share/man/man3/cap_to_text.3
  /usr/share/man/man3/capgetp.3
  /usr/share/man/man3/capsetp.3
  /usr/share/man/man3/libcap.3
  /usr/share/man/man8/getcap.8
  /usr/share/man/man8/setcap.8
)

