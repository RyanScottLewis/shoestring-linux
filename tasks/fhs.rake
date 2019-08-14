paths.os_fhs.explode.each do |path|
  next if path.to_s == paths.os_root.join('lib').to_s
  next if path.to_s == paths.os_root.join('lib64').to_s

  directory path
end

file paths.os_root.join('lib') do
  ln_sf '/usr/lib', paths.os_root.join('lib')
end

file paths.os_root.join('lib64') do
  ln_sf '/usr/lib', paths.os_root.join('lib64')
end

