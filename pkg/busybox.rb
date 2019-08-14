name      :busybox
version   '1.31.0'
archive   "https://busybox.net/downloads/busybox-#{version}.tar.bz2"
signature "#{archive}.sig"
checksum  "#{archive}.sha256"

on_build do |package|
  config_path = package.build_path.join('.config')

  unless config_path.exist?
    cd(package.build_path) { make :defconfig }

    update_config(package.build_path.join('.config'),
      'CONFIG_STATIC'  => ?y, # Statically link libraries
      'CONFIG_LINUXRC' => ?n, # Do not build linuxrc file
    )
  end

  cd(package.build_path) { make }
end

on_install do |package|
  cd(package.build_path) do
    make :install
    mkdir_p paths.project_root.join(paths.os_root, 'bin')
    mkdir_p paths.project_root.join(paths.os_root, 'sbin')
    cp '_install/bin/busybox', paths.project_root.join(paths.os_root, 'bin')
    ln_sf './busybox', paths.project_root.join(paths.os_root, 'bin', 'hostname')
    ln_sf './busybox', paths.project_root.join(paths.os_root, 'bin', 'mount')
    ln_sf '../bin/busybox', paths.project_root.join(paths.os_root, 'sbin', 'ifconfig')
    ln_sf '../bin/busybox', paths.project_root.join(paths.os_root, 'sbin', 'init')
    ln_sf '../bin/busybox', paths.project_root.join(paths.os_root, 'sbin', 'mdev')
  end
end

files %w(
  /bin/busybox
  /bin/hostname
  /bin/mount
  /bin/sh
  /sbin/ifconfig
  /sbin/init
  /sbin/mdev
)

