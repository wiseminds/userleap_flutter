#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint userleap_flutter.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'userleap_flutter'
  s.version          = '0.0.5'
  s.summary          = 'A flutter plugin for userleap'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'ekeh.wisdom@gmail.com' }
  s.source = {
    :git => 'https://github.com/wiseminds/userleap_flutter.git',
    :tag => s.version
  } 
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  # s.framework = 'UserLeapKit'
  s.platform = :ios, '10.3'
  s.dependency 'UserLeapKit', '~>4.1.0'

#   Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
   s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
   s.swift_version = '5.0'
   s.xcconfig = { 'OTHER_LDFLAGS' => '-framework UserLeapKit' }
  #  s.vendored_frameworks = 'UserLeapKit.framework'

end
