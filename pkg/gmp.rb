name      :gmp
version   '6.1.2'
archive   "https://gmplib.org/download/gmp/gmp-#{version}.tar.xz"
signature "#{archive}.sig"

on_build do |package|
  cd package.build_path do
    sh <<~EOS
      ./configure \
        --prefix=/usr \
        --enable-cxx \
        --enable-fat
    EOS

    make
  end
end

on_install do |package|
  cd(package.build_path) { make :install, 'DESTDIR' => paths.project_root.join(paths.os_root) }
end

files %w(
  /usr/include/gmp.h
  /usr/include/gmpxx.h
  /usr/lib/libgmp.so
  /usr/lib/libgmp.so.10
  /usr/lib/libgmp.so.10.3.2
  /usr/lib/libgmpxx.so
  /usr/lib/libgmpxx.so.4
  /usr/lib/libgmpxx.so.4.5.2
  /usr/share/info/gmp.info-1
  /usr/share/info/gmp.info-2
  /usr/share/info/gmp.info
)

