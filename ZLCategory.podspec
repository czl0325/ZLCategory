#
#  Be sure to run `pod spec lint ZLCategory.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "ZLCategory"
  s.version      = "0.0.8"
  s.summary      = "ZLCategory"
  s.description  = <<-DESC
  						整合的一些常用的category类
                   DESC

  s.homepage     = "https://github.com/czl0325/ZLCategory"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "陈昭良" => "295183917@qq.com" }

  #s.ios.frameworks = 'Foundation', 'UIKit'
  #s.osx.frameworks = 'Foundation', 'AppKit'

  #s.ios.deployment_target = "5.0"
  #s.osx.deployment_target = "10.7"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/czl0325/ZLCategory.git", :tag => "#{s.version}" }

  s.source_files  = "ZLCategory/ZLCategory/*.{h,m}"
  s.frameworks   = 'UIKit'
  s.requires_arc = true

end
