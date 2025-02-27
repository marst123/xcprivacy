Pod::Spec.new do |s|
  s.name         = 'xcprivacy'
  s.version      = '1.0.0'
  s.summary      = 'A local xcprivacy file.'
  s.description  = 'This pod contains a custom xcprivacy configuration file.'
  s.homepage     = 'https://your-homepage.com'
  s.author       = { 'YourName' => 'your@email.com' }
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.source       = { :path => '.' }
  
  # 确保 .xcprivacy 文件被包含
  s.preserve_paths = '*.xcprivacy'
  
  # 只包含资源文件，去除 source_files 配置
  s.resources = '*.xcprivacy'
  
  # 在 `pod install` 时自动执行 `privacy_info_installer.rb`
  s.prepare_command = <<-CMD
    echo "Running PrivacyInfoInstaller.rb"
    ruby PrivacyInfoInstaller.rb
  CMD
  
end
