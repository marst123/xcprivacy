# xcprivacy

`xcprivacy` is a tool used for the automatic installation and management of any third-party `PrivacyInfo.xcprivacy` file. Once configured, developers can easily integrate privacy information files into their projects.

## Installation

1. Extract the `xcprivacy` folder and manually drag it into your project's Pods directory.

2. Add the `xcprivacy` Pod to your `Podfile`:

    ```ruby
    target 'YourTarget' do
      pod 'xcprivacy', :path => './Pods/xcprivacy'
    end
    ```

3. Install the Pod dependencies:

    ```bash
    pod install
    ```

## Usage Instructions

### How to Configure the PrivacyInfo File

`xcprivacy` contains a file named `PrivacyInfo.xcprivacy`. During installation, `PrivacyInfoInstaller.rb` will copy this file to the target path you specify. You can configure the target path by modifying the `Podfile`.

```ruby
post_install do |installer|
    # Ensure PrivacyInfoInstaller.rb is loaded correctly
    require_relative File.expand_path('./Pods/xcprivacy/PrivacyInfoInstaller')

    # Define target path configurations for installation
    target_paths = {
      'MBProgressHUD' => '',  # Leave empty if no subfolder is needed
      'ReachabilitySwift' => 'Sources'  # Specify the subfolder if needed
    }
    # Execute the installation
    PrivacyInfoInstaller.install(installer, target_paths)
end

## Author

marst123, tianlan2325@qq.com

## License

Mlso is available under the MIT license. See the LICENSE file for more info.
