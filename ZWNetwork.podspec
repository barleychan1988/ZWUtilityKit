#
# Be sure to run `pod lib lint ZWUtilityKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZWNetwork'
  s.version          = '0.0.1'
  s.summary          = '常用网络检测方法；appstore升级版本检测.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
常用网络检测等方法
                       DESC

  s.homepage         = 'https://github.com/EadkennyChan/ZWUtilityKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Eadkennychan' => 'Eadkennychan@gmail.com' }
  s.source           = { :git => 'https://github.com/EadkennyChan/ZWUtilityKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/EadkennyChan'
  s.requires_arc = true

    s.ios.deployment_target = '6.0'
    s.vendored_frameworks ='*.framework'
    s.source_files = 'Network/*.{h,m}'
    s.dependency 'Reachability', '~> 3.2'
    s.dependency 'JSONKit-ZW', '~>2.0.4'
    s.xcconfig = {
        'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
        #'OTHER_LDFLAGS' => '"$(inherited)" "-lxml2" "-objc"'
    }
    s.frameworks = 'SystemConfiguration','Security','CoreLocation','QuartzCore','CFNetwork','MessageUI'
end
