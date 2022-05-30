source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '15.0'

use_frameworks!

target 'map-navigation' do
  pod 'GoogleMaps', '6.2.1'
#  pod 'Alamofire'
#  pod 'ObjectMapper'
  pod 'GoogleMapsDirections'
 # pod 'Google-Maps-iOS-Utils', '~> 4.1.0'    # 防火墙问题？ 加载不了，改用源码。
  
  # Use this plugin to manage the api key safely.
  # Check the details in `https://github.com/orta/cocoapods-keys`
  # First, use `gem install cocoapods-keys`
  # After everytime `pod install/update`,
  # it will check if you have these keys in your OS X keychain.
  # If not, it ask you for it, and save the api keys in keychains.
  # Then your use the api keys in your code by `MyApplicationKeys().YOUR_KEY_NAME`(with no - in your key name).
  # This process adds some rudimentary obfuscation to the keys.
  plugin 'cocoapods-keys', {
    :project => "MapNavigation",
    :keys => [
      "GoogleMapsAPIKey",
    ]}


end

