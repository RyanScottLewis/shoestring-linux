FS_TARGETS.each do |target_path|
  source_path = target_path.sub(paths.build_root, paths.fs)

  file target_path => source_path do
    sh <<~EOS
      cp -a '#{source_path}/.' '#{target_path}/'
    EOS
  end
end

