#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "AffiseSKAdNetwork"
  spec.version      = ENV['LIB_VERSION'] || "1.6.59"
  spec.summary      = "AffiseSKAdNetwork iOS library"
  spec.description  = "Affise library for StoreKit Ad Network (SKAdNetwork)"
  spec.homepage     = "https://github.com/affise/affise-mmp-sdk-ios"
  spec.license      = { :type => "MIT", :file => 'LICENSE' }
  spec.author       = { "Affise" => "support@affise.com" }
  spec.source       = { 
    :git => "https://github.com/affise/affise-mmp-sdk-ios.git", 
    :tag => "#{spec.version}" 
  }

  spec.source_files  = "AffiseSKAdNetwork/**/*.{h,m,swift}"
  spec.platform = "ios"
  spec.ios.deployment_target = "12.0"
  spec.swift_version = "5.7"

  spec.framework  = "StoreKit"
  spec.pod_target_xcconfig = { "DEFINES_MODULE" => "YES" }
end
