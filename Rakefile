# Add lib/ to Ruby load path
$LOAD_PATH.unshift(File.expand_path(File.join("..", "lib"), __FILE__))

# Require all RubyGems
require 'bundler/setup'

require 'rake/clean' # TODO: REMOVE

require 'helpers'

# TODO: Wouldnt hurt to push this upstream.. maybe some sort of system for helper modules?

class Path::Struct
  def remove_ext
    sub_ext('')
  end

  def symlink?
    File.symlink?(to_s)
  end
end

module PackageHelpers

  include FileUtils

  JOBS = `nproc`.to_i

  def make_build
    sh <<~EOS
      cd '#{build_path}'

      #{yield if block_given?}

      make -j#{JOBS}
    EOS
  end

  def make_install(env={})
    env = {
      'DESTDIR' => Path.all.os_root.expand_path
    }.merge(env).map { |k, v| [k, v].join(?=) }.join(' ')

    sh <<~EOS
      cd '#{build_path}'

      make #{env} install
    EOS
  end

  def compress_documentation
    documentation_paths = install_paths.
      select { |path| path.to_s =~ %r{/man/} && path.extname == '.gz' }

    documentation_paths.each do |compressed_path|
      decompressed_path = compressed_path.remove_ext

      if decompressed_path.symlink?
        rm    decompressed_path
        ln_sf decompressed_path, compressed_path
      else
        sh "gzip -9 --force '#{decompressed_path}'"
      end
    end
  end

  def strip_binaries
    install_paths.select { |path| path.to_s =~ %r{/bin/} }.each do |path|
      sh "strip --strip-all '#{path}'"
    end
  end

  def standard_install
    make_install
    #compress_documentation # TODO: This fucks everything up - Mostly cause symlinks
    strip_binaries
  end

  # kernel.org distributes packages in multiple compression formats, so instead of signing all of them
  # they sign the tar file, then compress it, so we have to reverse that process.
  def verify_compressed_archive
    decompressed_path = archive_path.remove_ext

    sh "xz --keep --decompress '#{archive_path}'" unless decompressed_path.exist?
    self.archive_path = decompressed_path

    sh "gpg --verify '#{signature_path}' '#{archive_path}'"
  end

  Package::Struct.prepend(self)

end


# == Config ========================================================================================

NAME      = 'shoestring-linux'
VERSION   = '0.0.1'
ISO_LABEL = 'Shoestring Linux ISO'

# == Paths =========================================================================================

FHS      = %w(bin boot dev/pts dev/shm etc lib proc sbin sys tmp usr/bin usr/sbin)
FHS_GLOB = "{#{FHS.join(?,)}}"

# Descriptive paths
path name: :build,            description: 'Linux root, ISO image root, etc.'
path name: :doc,              description: 'Project documentation'
path name: :lib,              description: 'Library sources'
path name: :pkg,              description: 'Package definitions'
path name: :src,              description: 'Project sources'
path name: :var,              description: 'Variable file storage'
path name: :fs,               description: 'Files to import into the Linux root path'
path name: :tasks,            description: 'Rake tasks'

path name: :isolinux_image,   description: 'ISOLINUX image',             path: '/usr/lib/syslinux/bios/isolinux.bin'
path name: :isolinux_ldlinux, description: 'ISOLINUX ldlinux',           path: '/usr/lib/syslinux/bios/ldlinux.c32'
path name: :isolinux_config,  description: 'ISOLINUX configuration',     path: paths.src.join('isolinux.cfg')

path name: :builds,           description: 'Package builds',             path: paths.var.join('builds')
path name: :sources,          description: 'Package sources',            path: paths.var.join('sources')
path name: :locks,            description: 'Package lock files',         path: paths.var.join('locks')

path name: :task_graph,       description: 'Rake task dependency graph', path: paths.doc.join('task_graph.png')

# Undescriptive paths
path name: :rakefile,             path: 'Rakefile'

path name: :linux_kernel,         path: -> { packages.linux.build_path.join(*%w[arch x86 boot bzImage]) } # TODO: Use `uname -m`

path name: :root,                 path: paths.build.join('root')

path name: :os_root,              path: paths.root.join('os')
path name: :os_boot,              path: paths.os_root.join('boot')
path name: :os_fhs,               path: paths.os_root.join(FHS_GLOB)
path name: :os_initrd,            path: paths.os_boot.join('initrd.cpio.gz')
path name: :os_kernel,            path: paths.os_boot.join('vmlinuz')

path name: :iso_root,             path: paths.root.join('iso')
path name: :iso_boot,             path: paths.iso_root.join('boot')
path name: :iso_initrd,           path: paths.iso_boot.join(NAME + '.' + paths.os_initrd.to_s.gsub(/^.+?\./, ''))
path name: :iso_kernel,           path: paths.iso_boot.join(NAME)
path name: :iso_isolinux,         path: paths.iso_root.join('isolinux')
path name: :iso_isolinux_image,   path: -> { paths.iso_isolinux.join(paths.isolinux_image.basename) }
path name: :iso_isolinux_ldlinux, path: -> { paths.iso_isolinux.join(paths.isolinux_ldlinux.basename) }
path name: :iso_isolinux_config,  path: paths.iso_isolinux.join(paths.isolinux_config.basename)
path name: :iso,                  path: paths.build.join("#{NAME}-#{VERSION}.iso")
path name: :iso_xz,               path: paths.iso.append_ext('.xz')

path name: :task_paths,           path: paths.tasks.join('**', '*.{rake,rb}')
path name: :fs_paths,             path: paths.fs.join('**', '*')
path name: :fs_targets,           path: paths.fs_paths.glob.sub(paths.fs, paths.os_root).join

# == Packages ======================================================================================

# Load all package specifications
Package.load_all(paths)

# == Clean =========================================================================================

CLEAN.include paths.sources
CLEAN.include paths.task_graph

CLOBBER.include paths.build
CLOBBER.include paths.var

# == Tasks =========================================================================================

# Load all tasks under tasks/
paths.task_paths.glob.each { |path| load(path) }

# Default Rakefile task
desc 'See: iso'
task default: 'iso'

