module PrivacyInfoInstaller
  def self.install(installer, target_paths)
    root_path = installer.pods_project.path.dirname
    xcprivacy_source = File.join(root_path, 'xcprivacy', 'PrivacyInfo.xcprivacy')

    # 检查源文件是否存在
    unless File.exist?(xcprivacy_source)
      raise "Error: xcprivacy/PrivacyInfo.xcprivacy does not exist at expected path: #{xcprivacy_source}"
    end

    target_paths.each do |target_name, privacy_folder_name|
      target = installer.pods_project.targets.find { |t| t.name == target_name }

      if target
        privacy_file_full_path = if privacy_folder_name.empty?
                                   File.join(root_path, target_name, 'PrivacyInfo.xcprivacy')
                                 else
                                   File.join(root_path, target_name, privacy_folder_name, 'PrivacyInfo.xcprivacy')
                                 end

        target_directory = File.dirname(privacy_file_full_path)
        Dir.mkdir(target_directory) unless Dir.exist?(target_directory)

        unless File.exist?(privacy_file_full_path)
          FileUtils.cp(xcprivacy_source, privacy_file_full_path)
        end

        pods_group = installer.pods_project.groups.find { |g| g.name == 'Pods' }
        if pods_group
          target_group = pods_group.groups.find { |g| g.name == target_name }

          if target_group
            target_group.new_file(privacy_file_full_path)
            target.resources_build_phase.add_file_reference(target_group.files.last)
          else
            puts "⚠️ 未找到 #{target_name} 的组"
          end
        else
          puts "⚠️ 未找到 Pods 组"
        end
      else
        puts "⚠️ 未找到 #{target_name} 的目标"
      end
    end
  end
end
