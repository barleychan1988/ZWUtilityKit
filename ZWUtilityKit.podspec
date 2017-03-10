#
# Be sure to run `pod lib lint ZWUtilityKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZWUtilityKit'
  s.version          = '3.0.10'
  s.summary          = '编译警告移除'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
经常用到的一些公共代码.为了方便使用进行的简单封装。
                       DESC

  s.homepage         = 'https://github.com/EadkennyChan/ZWUtilityKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Eadkennychan' => 'Eadkennychan@gmail.com' }
  s.source           = { :git => 'https://github.com/Eadkennychan/ZWUtilityKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/EadkennyChan'
  s.requires_arc = true

  s.ios.deployment_target = '6.0'
    s.default_subspec = 'Foundation'

    s.subspec 'Foundation' do |foundation|
        foundation.ios.deployment_target = '6.0'
        foundation.source_files = 'ZWUtilityKit/{*,Category/Foundation/*}.{h,m}'
        #foundation.exclude_files = 'SDWebImage/UIImage+WebP.{h,m}'
    end

    s.subspec 'CategoryUI' do |cate_ui|
        cate_ui.ios.deployment_target = '6.0'
        cate_ui.source_files = 'ZWUtilityKit/Category/UIKit/*.{h,m}'
        #cate_ui.exclude_files = 'SDWebImage/UIImage+WebP.{h,m}'
        cate_ui.dependency 'ZWUtilityKit/Foundation'
    end

    s.subspec 'Network' do |network|
    network.ios.deployment_target = '6.0'
    network.source_files = 'ZWUtilityKit/Network/*.{h,m}'
    network.dependency 'Reachability'
    #network.exclude_files = ''
    network.xcconfig = {
        'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
        #'OTHER_LDFLAGS' => '"$(inherited)" "-lxml2" "-objc"'
    }
    network.frameworks = 'CFNetwork'
    end

#s.frameworks = 'SystemConfiguration','Security','CoreLocation','QuartzCore','CFNetwork','MessageUI'
  
  # s.resource_bundles = {
  #   'ZWUtilityKit' => ['ZWUtilityKit/Assets/*.png']
  # }
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
